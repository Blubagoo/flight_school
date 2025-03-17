// Ensure this only runs on the server
if (!isServer) exitWith {}; 

private _taskManager = createHashMap;

// Store created tasks
_taskManager set ["tasks", []];

// Function: Create Task
_taskManager set ["createTask", {
    if (!isServer) exitWith {}; // Ensure only server executes this

    params ["_taskID", "_taskTitle", "_taskDescription", "_taskMarker", "_taskType", ["_state", "ASSIGNED"], ["_priority", 1]];

    private _position = getMarkerPos _taskMarker;
    [true, _taskID, [_taskDescription, _taskTitle, _taskMarker], _position, _state, _priority, true, _taskType, true] remoteExec ["BIS_fnc_taskCreate", 0, _taskID];

    private _tasks = missionNamespace getVariable ["TaskManager", createHashMap] get "tasks";
    _tasks pushBack _taskID;
}];

// Function: Update Task
_taskManager set ["updateTask", {
    if (!isServer) exitWith {}; // Ensure only server executes this
    params ["_taskID", "_state"];

    [_taskID, _state] remoteExec ["BIS_fnc_taskSetState", 0];
}];

// Function: Complete Task
_taskManager set ["completeTask", {
    if (!isServer) exitWith {}; 
    params ["_taskID"];

    [_taskID, "SUCCEEDED"] remoteExec ["BIS_fnc_taskSetState", 0];

    private _tasks = missionNamespace getVariable ["TaskManager", createHashMap] get "tasks";
    _tasks deleteAt (_tasks find _taskID);
}];

// Function: Fail Task
_taskManager set ["failTask", {
    if (!isServer) exitWith {}; 
    params ["_taskID"];

    [_taskID, "FAILED"] remoteExec ["BIS_fnc_taskSetState", 0];

    private _tasks = missionNamespace getVariable ["TaskManager", createHashMap] get "tasks";
    _tasks deleteAt (_tasks find _taskID);
}];

// Function: Delete Task
_taskManager set ["deleteTask", {
    if (!isServer) exitWith {}; 
    params ["_taskID"];

    [_taskID] remoteExec ["BIS_fnc_deleteTask", 0];

    private _tasks = missionNamespace getVariable ["TaskManager", createHashMap] get "tasks";
    _tasks deleteAt (_tasks find _taskID);
}];

// Store in missionNamespace
missionNamespace setVariable ["TaskManager", _taskManager];

diag_log "TaskManager initialized on the server.";
