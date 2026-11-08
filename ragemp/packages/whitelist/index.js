// Add permitted RAGE:MP player names to this list.
// This starter whitelist uses player.name; only share the server with people you trust.
const WHITELIST = [
    "YOUR_PLAYER_NAME"
];

mp.events.add("playerJoin", (player) => {
    if (!WHITELIST.includes(player.name)) {
        player.kick("This is a private server. You are not on the whitelist.");
        return;
    }

    console.log(`[whitelist] Allowed ${player.name}`);
});
