
function BrowserGeocode() {
  navigator.geolocation.getCurrentPosition(function gotGeocode(geocode) {
    window.location = `/search/?lat=${geocode.coords.latitude}&lng=${geocode.coords.longitude}`
  });
}
