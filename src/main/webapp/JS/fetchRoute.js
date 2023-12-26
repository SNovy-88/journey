// Function to fetch route
async function fetchRoute(coordinates) {
    const url = 'https://api.openrouteservice.org/v2/directions/foot-hiking/geojson';

    const body = {
        coordinates: coordinates.map(wp => [wp.lng, wp.lat]),
        format: 'geojson',
        elevation: true
    };

    //console.log(JSON.stringify(body));

    const response = await fetch(url, {
        method: 'POST',
        body: JSON.stringify(body),
        headers: {
            'Accept': 'application/json, application/geo+json, application/gpx+xml, img/png; charset=utf-8',
            'Content-Type': 'application/json; charset=utf-8',
            'Authorization': ORS_API_KEY
        }
    });

    //console.log("response: ", JSON.stringify(response));
    //console.log(response);

    if (!response.ok) {
        const message = response.statusText;
        throw new Error(message);
    }

    const responseData = await response.json();

    if (responseData.features && responseData.features.length > 0) {
        const segment = responseData.features[0].properties.segments[0];
        var routeData = {
            distance: segment.distance,
            duration: segment.duration,
            ascent: segment.ascent,
            descent: segment.descent
        };

        //console.log("Distance: ${totalDistance} meters, Duration: ${totalDuration} seconds, Ascent: ${totalAscent} meters, Descent: ${totalDescent} meters");
    }

    console.log("Responsedata!");
    console.log(responseData);

    return {geojson: responseData, details: routeData};
}