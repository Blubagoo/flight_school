// File: initServer.sqf


if (!isServer) exitWith {}; // Ensure it runs on the server only

call compile preprocessFileLineNumbers "scripts\serverClasses\TaskManager.sqf";
call compile preprocessFileLineNumbers "scripts\serverClasses\DestroyTargetTask.sqf";

diag_log "TaskManager loaded on the server.";