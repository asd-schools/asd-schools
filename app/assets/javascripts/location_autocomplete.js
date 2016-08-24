
function BrowserGeocode() {
  navigator.geolocation.getCurrentPosition(function gotGeocode(geocode) {
    window.location = "/search/?lat=" +
      encodeURIComponent(geocode.coords.latitude) +
      "&lng=" +
      encodeURIComponent(geocode.coords.longitude)
  });
}
