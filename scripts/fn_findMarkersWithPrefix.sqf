// Function to find markers with a specific prefix
// Parameter: _prefix (String) - The prefix to search for
// Returns: Array of marker names matching the prefix

findMarkersWithPrefix = {
    params ["_prefix"];
    private _matchingMarkers = [];

    {
        if ((toLower (_x select [0, count _prefix])) isEqualTo (toLower _prefix)) then {
            _matchingMarkers pushBack _x;
        };
    } forEach allMapMarkers;

    _matchingMarkers
};

