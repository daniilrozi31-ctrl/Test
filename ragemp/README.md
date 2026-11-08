# Test — private RAGE:MP server starter for Windows

This is a small configuration and name-based whitelist template. It does **not** include the RAGE:MP server runtime or GTA V; obtain server files from the official RAGE:MP site and use its current installation instructions.

## Install on your Windows computer

1. Install/download the RAGE:MP server runtime from the official RAGE:MP website.
2. In the server runtime folder, back up its existing `conf.json` if present.
3. Copy this repository's `ragemp/conf.json` into the runtime folder.
4. Copy this repository's entire `ragemp/packages/whitelist` folder into the runtime's `packages` folder. The resulting path should be `packages/whitelist/index.js` with `whitelist.json` beside it.
5. Edit `packages/whitelist/whitelist.json` in Notepad. Replace `YOUR_PLAYER_NAME` with your exact RAGE:MP player name. To add more players, use valid JSON, for example:

   ```json
   [
     "YourName",
     "FriendName"
   ]
   ```

6. Copy `ragemp/start_server.bat` into the runtime folder, beside `ragemp-server.exe`.
7. Double-click `start_server.bat`. Keep its console window open while playing.
8. On the same computer, connect in RAGE:MP to `127.0.0.1:22005`.

The whitelist is checked when a player joins. If `whitelist.json` is missing or invalid, the script rejects everyone (fail-closed). Names are not strong account authentication; use this only for a small test with trusted people. `announce` is disabled in the provided config, but that alone does not provide network access control.

## Letting friends connect

First test locally. For remote friends, you must separately configure Windows Firewall and your router/NAT for the server's required ports, and share your public address only with trusted players. Do not disable your firewall or expose remote access if you are unsure; ask a trusted adult or network administrator to help. Internet providers may use CGNAT, which can prevent hosting from home.

The exact ports/protocols and setup may vary by RAGE:MP server version; follow the official documentation. This template does not configure router or firewall rules automatically.
