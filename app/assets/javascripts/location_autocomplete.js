BrowserGeocode = () => {
  navigator.geolocation.getCurrentPosition((geocode) =>
    window.location.pathname = `/search/?lat=${geocode.coords.latitude}&lng=${geocode.coords.longitude}`
  );
}
