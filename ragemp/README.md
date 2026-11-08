# Test — private RAGE:MP server starter (Windows)

This repository contains a small private-server configuration and a name-based whitelist script. The RAGE:MP server runtime itself is not included; download it from the official RAGE:MP website and follow its server setup instructions.

## Setup on your computer

1. Install the RAGE:MP server files using the official instructions.
2. Copy `ragemp/conf.json` into the server root, replacing its sample `conf.json`.
3. Copy `ragemp/packages/whitelist` into the server's `packages` directory.
4. Edit `packages/whitelist/index.js` and replace `YOUR_PLAYER_NAME` with your exact RAGE:MP player name. Add other allowed names as additional quoted entries separated by commas.
5. Start `ragemp-server.exe` from the server root.
6. In RAGE:MP, connect to `127.0.0.1:22005` to test locally on the same computer.

`announce` is disabled. To let friends connect over the internet, you will need to configure Windows Firewall and your router to allow the server port, and share your public address only with trusted players. Do not expose the server unless you understand those network settings.

The starter whitelist checks player names, which are not a strong identity or authentication mechanism. Use it only for a small private test with trusted people; do not treat it as secure account verification.
