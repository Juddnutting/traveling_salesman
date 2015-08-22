
function initMap() {
  var map = new google.maps.Map(document.getElementById('map-canvas'), {
    zoom: 3,
    center: { lat: 39.7, lng: -104.5},
    mapTypeId: google.maps.MapTypeId.TERRAIN
  });

  var flightPlanCoordinates = [
    {lat: 39.7, lng: -104.5},
    {lat: 20, lng: -100},
    {lat: 20, lng: -80},
    {lat: 39, lng: -105}
  ];
  var flightPath = new google.maps.Polyline({
    path: flightPlanCoordinates,
    geodesic: true,
    strokeColor: '#FF0000',
    strokeOpacity: 1.0,
    strokeWeight: 2
  });

  flightPath.setMap(map);
}