// DestroyTargetTask.sqf - Handles the creation and completion of a Destroy Target Task

if (!isServer) exitWith { diag_log "[DestroyTargetTask] Not running on server! Exiting."; };

// Ensure TaskManager exists in missionNamespace
if (isNil "TaskManager") then {
    missionNamespace setVariable ["TaskManager", createHashMap];
};
private _taskManager = missionNamespace getVariable ["TaskManager", createHashMap];

// Function to create and assign a destroy target task
private _createDestroyTargetTask = {
    params ["_taskID", "_taskTitle", "_taskDescription", "_pos", "_unitTypes"];

    diag_log format ["[DestroyTargetTask] Creating task: %1 at %2 with units %3", _taskID, _pos, _unitTypes];

    // Create map marker
    private _markerName = format ["marker_%1", _taskID];
    private _marker = createMarker [_markerName, _pos];
    _marker setMarkerType "mil_destroy";
    _marker setMarkerColor "ColorRed";

    // Create trigger for enemy detection
    private _triggerName = format ["DestroyTargetTask_Trigger_%1", _taskID];
    private _trigger = createTrigger ["EmptyDetector", _pos];
    _trigger setTriggerArea [3, 3, 0, false];
    _trigger setTriggerActivation ["ANY", "PRESENT", true];
    missionNamespace setVariable [_triggerName, _trigger];

    // Spawn enemies
    private _spawnedUnits = [];
    {
        private _count = floor (random 5) + 1; // 1-5 units per type
        private _group = createGroup east;
        _group setCombatMode "BLUE";
        _group setBehaviour "CARELESS";

        for "_i" from 1 to _count do {
            private _unit = _group createUnit [_x, _pos, [], 0, "NONE"];
            { _unit disableAI _x; } forEach ["MOVE", "TARGET", "AUTOTARGET", "FSM", "SUPPRESSION"];
            _unit setUnitPos "UP";
			removeAllWeapons _unit;
            removeAllContainers _unit;
            removeAllAssignedItems _unit;
            _unit setVariable ["BIS_noCoreConversations", true]; // Prevent radio issues
            _spawnedUnits pushBack _unit;
        };
    } forEach _unitTypes;

    // Ensure TaskManager exists before using it
    private _taskManager = missionNamespace getVariable ["TaskManager", createHashMap];
    private _createTaskFunction = _taskManager get "createTask";

    if (typeName _createTaskFunction == "CODE") then {
        [_taskID, _taskTitle, _taskDescription, _markerName, "DESTROY"] call _createTaskFunction;
    } else {
        diag_log "[DestroyTargetTask] ERROR: TaskManager createTask function not found!";
    };

    // Start damage tracking if function exists
    private _fn_displayZoneStatus = missionNamespace getVariable ["FlightSchool_fnc_displayZoneStatus", {}];
    if (typeName _fn_displayZoneStatus == "CODE") then {
        [_pos, _taskID] spawn _fn_displayZoneStatus;
    };

    // Monitor enemy units and complete task upon their elimination
    [_spawnedUnits, _taskID] spawn {
        params ["_units", "_taskID"];
        waitUntil { sleep 1; {alive _x} count _units == 0 };

        // Ensure TaskManager exists before using it
        private _taskManager = missionNamespace getVariable ["TaskManager", createHashMap];
        private _completeTaskFunction = _taskManager get "completeTask";
        if (typeName _completeTaskFunction == "CODE") then {
            [_taskID] call _completeTaskFunction;
        };

        // Cleanup marker and trigger
        deleteMarker format ["marker_%1", _taskID];
        private _triggerName = format ["DestroyTargetTask_Trigger_%1", _taskID];
        private _storedTrigger = missionNamespace getVariable [_triggerName, objNull];
        if (!isNull _storedTrigger) then {
            deleteVehicle _storedTrigger;
        };
    };
};

// Store function in missionNamespace for remote execution
missionNamespace setVariable ["DestroyTargetTask_createTask", _createDestroyTargetTask];

diag_log "[DestroyTargetTask] Initialized on the server.";