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
[true, _taskID1, [_taskDescription, _taskTitle, _taskMarker1], getMarkerPos _taskMarker1, "ASSIGNED", 1, true, "DESTROY", true] call BIS_fnc_taskCreate;

// Create the task
[true, _taskID2, [_taskDescription, _taskTitle, _taskMarker2], getMarkerPos _taskMarker2, "ASSIGNED", 1, true, "DESTROY", true] call BIS_fnc_taskCreate;

// Create the task
[true, _taskID3, [_taskDescription, _taskTitle, _taskMarker3], getMarkerPos _taskMarker3, "ASSIGNED", 1, true, "DESTROY", true] call BIS_fnc_taskCreate;


// Initialize damage tracking variables
missionNamespace setVariable ["zone1Damaged", false, true];
missionNamespace setVariable ["zone2Damaged", false, true];
missionNamespace setVariable ["zone3Damaged", false, true];

// Start monitoring task progress
[] execVM "scripts\tasks\pilot_task_industrial_complex\pilot_task_monitor.sqf";
// Start displaying damage status
[] execVM "scripts\tasks\pilot_task_industrial_complex\pilot_task_display.sqf";


hint "task 1 init loaded";