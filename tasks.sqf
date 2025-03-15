// File: tasks.sqf


// Assign zone names to each zone object
// zone1 setVariable ["zoneName", "zone1"];
// zone2 setVariable ["zoneName", "zone2"];
// zone3 setVariable ["zoneName", "zone3"];

// Assign HandleDamage event handlers to each zone
// {
//     _zone = _x;
//     _zone addEventHandler ["HandleDamage", {
//         params ["_target", "_source", "_damage", "_instigator"];
//         private _zoneName = _target getVariable ["zoneName"];
//         if (!missionNamespace getVariable [_zoneName, false]) then {
//             missionNamespace setVariable [_zoneName, true, true];
//             hint format ["Damage detected in %1", _zoneName];
//         };
//     }];
// } forEach [zone1, zone2, zone3];

// Execute Task 1 Script
[] execVM "scripts\tasks\pilot_task_industrial_complex\pilot_task_init.sqf";

// Execute Task 2 Script
// [] execVM "task2.sqf";

// Add additional tasks as needed
