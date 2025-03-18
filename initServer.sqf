// File: initServer.sqf


if (!isServer) exitWith {}; // Ensure it runs on the server only

call compile preprocessFileLineNumbers "scripts\serverClasses\TaskManager.sqf";
call compile preprocessFileLineNumbers "scripts\serverClasses\DestroyTargetTask.sqf";
// call compile preprocessFileLineNumbers "scripts\fn_findMarkersWithPrefix.sqf";
// call compile preprocessFileLineNumbers "scripts\fn_findRandomMarkerWithPrefix.sqf";

diag_log "TaskManager loaded on the server.";