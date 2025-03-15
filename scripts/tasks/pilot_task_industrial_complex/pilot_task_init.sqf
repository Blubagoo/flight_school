// Define task parameters
_taskID1 = "task1";
_taskID2 = "task2";
_taskID3 = "task3";
_taskTitle = "Destroy Industrial Complex";
_taskDescription = "Bomb the industrial complex to slow the enemies progress.";
_taskMarker1 = "task1Marker"; // Ensure this marker is placed in the editor
_taskMarker2 = "task2Marker"; // Ensure this marker is placed in the editor
_taskMarker3 = "task3Marker"; // Ensure this marker is placed in the editor

// Create the task
[_taskID1, true, [_taskTitle, _taskDescription, _taskMarker1], getPosATL player, 1] call BIS_fnc_taskCreate;
// Create the task
[_taskID2, true, [_taskTitle, _taskDescription, _taskMarker2], getPosATL player, 1] call BIS_fnc_taskCreate;
// Create the task
[_taskID3, true, [_taskTitle, _taskDescription, _taskMarker3], getPosATL player, 1] call BIS_fnc_taskCreate;

// Initialize damage tracking variables
missionNamespace setVariable ["zone1Damaged", false, true];
missionNamespace setVariable ["zone2Damaged", false, true];
missionNamespace setVariable ["zone3Damaged", false, true];

// Start monitoring task progress
[] execVM "scripts\tasks\pilot_task_industrial_complex\pilot_task_monitor.sqf";
// Start displaying damage status
// [] execVM "pilot_task_display.sqf";

hint "task 1 init loaded";