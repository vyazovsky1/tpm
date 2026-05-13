#!/usr/bin/env node
/**
 * Google OAuth setup for AITPM framework.
 * Obtains a refresh token covering Gmail, Drive, and Calendar,
 * then saves credentials to .env in the project root.
 *
 * Usage: node scripts/google-auth.js
 *
 * Prerequisites:
 *   1. Create a Google Cloud project at https://console.cloud.google.com
 *   2. Enable Gmail API, Drive API, and Calendar API
 *   3. Create OAuth 2.0 credentials (type: Desktop app)
 *   4. Copy the Client ID and Client Secret when prompted
 */

const http = require('http');
const https = require('https');
const { exec } = require('child_process');
const fs = require('fs');
const path = require('path');
const readline = require('readline');
const crypto = require('crypto');

const PROJECT_ROOT = path.resolve(__dirname, '..');
const ENV_FILE = path.join(PROJECT_ROOT, '.env');
const PORT = 3456;
const REDIRECT_URI = `http://localhost:${PORT}/callback`;

const SCOPES = [
  'https://www.googleapis.com/auth/gmail.modify',
  'https://www.googleapis.com/auth/drive',
  'https://www.googleapis.com/auth/calendar.readonly'
].join(' ');

function openBrowser(url) {
  let cmd;
  if (process.platform === 'win32') {
    cmd = `start "" "${url}"`;
  } else {
    // WSL2: try wslview, then xdg-open, then cmd.exe
    cmd = `{ command -v wslview && wslview "${url}"; } 2>/dev/null || \
           { command -v xdg-open && xdg-open "${url}"; } 2>/dev/null || \
           cmd.exe /c start "${url}" 2>/dev/null || true`;
  }
  exec(cmd, (err) => {
    if (err) console.log(`\nCould not open browser automatically. Open this URL manually:\n\n  ${url}\n`);
  });
}

function exchangeCode(clientId, clientSecret, code) {
  return new Promise((resolve, reject) => {
    const body = new URLSearchParams({
      code,
      client_id: clientId,
      client_secret: clientSecret,
      redirect_uri: REDIRECT_URI,
      grant_type: 'authorization_code'
    }).toString();

    const req = https.request({
      hostname: 'oauth2.googleapis.com',
      path: '/token',
      method: 'POST',
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Content-Length': Buffer.byteLength(body)
      }
    }, (res) => {
      let data = '';
      res.on('data', chunk => data += chunk);
      res.on('end', () => {
        try { resolve(JSON.parse(data)); }
        catch (e) { reject(new Error(`Could not parse token response: ${data}`)); }
      });
    });
    req.on('error', reject);
    req.write(body);
    req.end();
  });
}

function saveToEnv(vars) {
  let content = fs.existsSync(ENV_FILE) ? fs.readFileSync(ENV_FILE, 'utf8') : '';
  for (const [key, value] of Object.entries(vars)) {
    const line = `${key}=${value}`;
    const regex = new RegExp(`^${key}=.*$`, 'm');
    if (regex.test(content)) {
      content = content.replace(regex, line);
    } else {
      if (content && !content.endsWith('\n')) content += '\n';
      content += line + '\n';
    }
  }
  fs.writeFileSync(ENV_FILE, content);
}

function prompt(question) {
  const rl = readline.createInterface({ input: process.stdin, output: process.stdout });
  return new Promise(resolve => rl.question(question, answer => { rl.close(); resolve(answer.trim()); }));
}

function waitForCode() {
  return new Promise((resolve, reject) => {
    const server = http.createServer((req, res) => {
      const url = new URL(req.url, `http://localhost:${PORT}`);
      const code = url.searchParams.get('code');
      const error = url.searchParams.get('error');

      if (error) {
        res.writeHead(200, { 'Content-Type': 'text/html' });
        res.end(`<html><body style="font-family:sans-serif;padding:2rem">
          <h2>Authentication failed</h2><p>${error}</p><p>You can close this tab.</p>
        </body></html>`);
        server.close();
        reject(new Error(`OAuth error: ${error}`));
        return;
      }

      if (code) {
        res.writeHead(200, { 'Content-Type': 'text/html' });
        res.end(`<html><body style="font-family:sans-serif;padding:2rem">
          <h2>✓ Authenticated successfully!</h2>
          <p>You can close this tab and return to the terminal.</p>
        </body></html>`);
        server.close();
        resolve(code);
      }
    });

    server.on('error', err => {
      if (err.code === 'EADDRINUSE') {
        reject(new Error(`Port ${PORT} is already in use. Stop any process using it and retry.`));
      } else {
        reject(err);
      }
    });

    server.listen(PORT, () => {
      console.log(`Waiting for OAuth callback on http://localhost:${PORT} ...`);
    });
  });
}

async function main() {
  console.log('\n=== AITPM Google OAuth Setup ===');
  console.log('Scopes: Gmail (modify), Drive, Calendar (read)\n');
  console.log('You need a Google Cloud OAuth 2.0 Client ID (type: Desktop app).');
  console.log('Create one at: https://console.cloud.google.com/apis/credentials\n');

  const clientId = await prompt('Client ID     : ');
  const clientSecret = await prompt('Client Secret : ');

  if (!clientId || !clientSecret) {
    console.error('\nClient ID and Client Secret are required.');
    process.exit(1);
  }

  const state = crypto.randomBytes(16).toString('hex');
  const authUrl = 'https://accounts.google.com/o/oauth2/v2/auth?' + new URLSearchParams({
    client_id: clientId,
    redirect_uri: REDIRECT_URI,
    response_type: 'code',
    scope: SCOPES,
    access_type: 'offline',
    prompt: 'consent',
    state
  }).toString();

  console.log('\nOpening browser for Google sign-in...');
  openBrowser(authUrl);

  let code;
  try {
    code = await waitForCode();
    console.log('Authorization code received.');
  } catch (err) {
    console.error(`\nFailed to receive authorization code: ${err.message}`);
    process.exit(1);
  }

  console.log('Exchanging code for tokens...');
  let tokens;
  try {
    tokens = await exchangeCode(clientId, clientSecret, code);
  } catch (err) {
    console.error(`\nToken exchange failed: ${err.message}`);
    process.exit(1);
  }

  if (tokens.error) {
    console.error(`\nToken error: ${tokens.error} — ${tokens.error_description}`);
    process.exit(1);
  }

  if (!tokens.refresh_token) {
    console.error('\nNo refresh token returned. This usually means the account already authorized this app.');
    console.error('Revoke access at https://myaccount.google.com/permissions and run this script again.');
    process.exit(1);
  }

  saveToEnv({
    GOOGLE_OAUTH_CLIENT_ID: clientId,
    GOOGLE_OAUTH_CLIENT_SECRET: clientSecret,
    GOOGLE_OAUTH_REFRESH_TOKEN: tokens.refresh_token
  });

  console.log('\n✓ Credentials saved to .env:');
  console.log('  GOOGLE_OAUTH_CLIENT_ID');
  console.log('  GOOGLE_OAUTH_CLIENT_SECRET');
  console.log('  GOOGLE_OAUTH_REFRESH_TOKEN');
  console.log('\nRestart Claude Code to activate the MCP servers.\n');
}

main().catch(err => {
  console.error('\nUnexpected error:', err.message);
  process.exit(1);
});
