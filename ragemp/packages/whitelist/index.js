// Local name-based allowlist for a small private test server.
// Edit whitelist.json in this folder; no code changes are needed.
const fs = require("fs");
const path = require("path");

const whitelistPath = path.join(__dirname, "whitelist.json");

function loadWhitelist() {
    try {
        const names = JSON.parse(fs.readFileSync(whitelistPath, "utf8"));
        if (!Array.isArray(names) || !names.every((name) => typeof name === "string")) {
            throw new Error("whitelist.json must contain a JSON array of player names");
        }
        return new Set(names.map((name) => name.trim().toLowerCase()).filter(Boolean));
    } catch (error) {
        console.error(`[whitelist] Could not load ${whitelistPath}: ${error.message}`);
        return new Set(); // Fail closed: no players are admitted if the allowlist is invalid.
    }
}

mp.events.add("playerJoin", (player) => {
    const allowedNames = loadWhitelist();
    const playerName = String(player.name || "").trim();

    if (!allowedNames.has(playerName.toLowerCase())) {
        console.log(`[whitelist] Rejected ${playerName || "unknown player"}`);
        player.kick("Private server: your player name is not on the whitelist.");
        return;
    }

    console.log(`[whitelist] Allowed ${playerName}`);
});
