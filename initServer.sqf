// File: initServer.sqf


if (!isServer) exitWith {}; // Ensure it runs on the server only

call compile preprocessFileLineNumbers "functions\TaskManager.sqf";

diag_log "TaskManager loaded on the server.";