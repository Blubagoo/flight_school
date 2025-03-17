// DestroyTargetTask.sqf - Handles the creation and completion of a Destroy Target Task

if (!isServer) exitWith { diag_log "[DestroyTargetTask] Not running on server! Exiting."; };

private _DestroyTargetTask = createHashMap;

_DestroyTargetTask set ["createTask", {
    params ["_taskID", "_taskTitle", "_taskDescription", "_pos", "_unitTypes"];
    
    diag_log format ["[DestroyTargetTask] Received request to create task: %1 at %2 with units %3", _taskID, _pos, _unitTypes];

    private _markerName = format ["marker_%1", _taskID];
    private _triggerName = format ["trigger_%1", _taskID];

    // Create map marker
    private _marker = createMarker [_markerName, _pos];
    _marker setMarkerType "mil_destroy";
    _marker setMarkerColor "ColorRed";

    diag_log format ["[DestroyTargetTask] Created marker %1 at position %2", _markerName, _pos];

    // Create Trigger for enemy detection
    private _trigger = createTrigger ["EmptyDetector", _pos];
    _trigger setTriggerArea [3, 3, 0, false];
    _trigger setTriggerActivation ["ANY", "PRESENT", true];

    diag_log format ["[DestroyTargetTask] Created trigger %1 at position %2", _triggerName, _pos];

    // Spawn Enemies (Random 1-5 of each type)
    private _spawnedUnits = [];
    {
        private _count = floor (random 5) + 1; // 1-5 units per type
        diag_log format ["[DestroyTargetTask] Spawning %1 units of type %2", _count, _x];

        private _group = createGroup east;  // Create a group for the enemy units

        for "_i" from 1 to _count do {
            private _unit = _group createUnit [_x, _pos, [], 0, "NONE"];
            _spawnedUnits pushBack _unit;
            diag_log format ["[DestroyTargetTask] Spawned unit of type %1 at %2", _x, _pos];
        };
    } forEach _unitTypes;

    diag_log format ["[DestroyTargetTask] Assigning task: %1", _taskID];

    private _taskManager = missionNamespace getVariable ["TaskManager", createHashMap];

	if (isNil "_taskManager" || {typeName _taskManager != "HASHMAP"}) then {
		diag_log "[DestroyTargetTask] ERROR: TaskManager not found!";
	} else {
		private _createTaskFunction = _taskManager get "createTask";

		if (isNil "_createTaskFunction") then {
			diag_log "[DestroyTargetTask] ERROR: TaskManager createTask function not found!";
		} else {
			[_taskID, _taskTitle, _taskDescription, _markerName, "DESTROY"] call _createTaskFunction;
			diag_log format ["[DestroyTargetTask] Task %1 assigned successfully!", _taskID];
		};
	};

    diag_log format ["[DestroyTargetTask] Starting damage tracking for %1", _taskID];
    [_pos, _taskID] spawn fn_displayZoneStatus;

    [_spawnedUnits, _taskID] spawn {
        params ["_units", "_taskID"];
        waitUntil { sleep 1; {alive _x} count _units == 0 };

        diag_log format ["[DestroyTargetTask] All enemies eliminated for task: %1. Marking as complete.", _taskID];

        (missionNamespace getVariable ["TaskManager", createHashMap] get "completeTask") 
            call [_taskID];

        deleteMarker format ["marker_%1", _taskID];
        deleteVehicle format ["trigger_%1", _taskID];
        diag_log format ["[DestroyTargetTask] Cleaned up marker and trigger for task: %1", _taskID];
    };
}];

missionNamespace setVariable ["DestroyTargetTask_createTask", _DestroyTargetTask get "createTask"];

diag_log "[DestroyTargetTask] Initialized on the server.";
