function getWaypointIcon(type) {
    let customIconUrl;

    switch (type) {
        case 'poi':
            customIconUrl = 'pictures/Leaflet/pin-icon-poi.png';
            break;
        case 'hut':
            customIconUrl = 'pictures/Leaflet/pin-icon-hut.png';
            break;
        default:
            customIconUrl = 'pictures/Leaflet/pin-icon-wpt.png';
            break;
    }

    return L.icon({
        iconUrl: customIconUrl,
        iconSize: [64, 64],
        iconAnchor: [32, 64],
        popupAnchor: [0, -32]
    });
}