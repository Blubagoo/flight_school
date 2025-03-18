// Function to find a random marker with a specific prefix  
findRandomMarkerWithPrefix = {  
    params ["_prefix"];  

    // Load function from external file
    private _matchingMarkers = [_prefix] call FlightSchool_fnc_findMarkersWithPrefix;  

    if (count _matchingMarkers > 0) then {  
        private _randomMarker = selectRandom _matchingMarkers;  
        getMarkerPos _randomMarker;
    } else {  
        [] // Return empty array if no markers found
    };  
};
