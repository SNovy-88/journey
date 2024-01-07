// Function to parse GPX data and extract waypoints
function parseGPX(gpxData) {
    const parser = new DOMParser();
    const xmlDoc = parser.parseFromString(gpxData, 'text/xml');
    const waypoints = Array.from(xmlDoc.querySelectorAll('trkpt')).map((wpt) => ({
        lat: parseFloat(wpt.getAttribute('lat')),
        lon: parseFloat(wpt.getAttribute('lon')),
        name: wpt.querySelector('name').textContent.trim() || 'Unnamed Waypoint',
        type: wpt.querySelector('type').textContent.trim() || 'standard',
    }));

    return waypoints;
}