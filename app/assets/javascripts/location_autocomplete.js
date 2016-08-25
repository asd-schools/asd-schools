
function BrowserGeocode() {
  navigator.geolocation.getCurrentPosition(function gotGeocode(geocode) {
    window.location = "/search/?lat=" +
      encodeURIComponent(geocode.coords.latitude) +
      "&lng=" +
      encodeURIComponent(geocode.coords.longitude)
  });
}

function SuburbAutocomplete(selector, datasource) {
  var ul = document.createElement("ul")
  $(selector).after(ul)
  $(selector).on('input', function onSuburbChange(ev) {
    datasource(ev.target.value, function setContent(html) {
      ul.innerHTML = html
    });
  })
}

function GistSuburbAutocomplete(input, cb) {
  $.getJSON(
    "/suburbs?q="+encodeURIComponent(input)
  ).then(function onSuburbJsonLoaded(suburbs) {
    cb(
      suburbs.map(GistSuburbTemplate).join("")
    )
  });
}

function ConsumerSuggestAutocomplete(input, cb) {
  var baseUrl = "https://suggest.realestate.com.au/consumer-suggest/suggestions";

  $.getJSON({
    url: baseUrl + "?max=20&src=autism-schools-reaio&type=suburb,region,precinct,postcode&query=" + encodeURIComponent(input),
  }).then(function suburbAutocompleteResponse(response) {
    cb(response._embedded.suggestions.map(ConsumerSuggestTemplate).join(""));
  }, function errorCallback(response) {
    console.log("error", response);
  });
}

function ConsumerSuggestTemplate(suggestion) {
  return "" +
    "<li class='autocomplete-result'>" +
      "<a href='/search/?atlas_id=" + encodeURIComponent(suggestion.id.slice(0, 36)) + "'>" +
        suggestion.display.text +
      "</a>" +
    "</li>";
}

function GistSuburbTemplate(suburb) {
  return "" +
    "<li class='autocomplete-result'>" +
      "<a href='/search/?lat=" + suburb.point.x + "&lng=" + suburb.point.y + "'>" +
        "<span class='suburbname'>" + suburb.name + "</span> " +
        "<span class='postcode'>" + suburb.postcode + "</span> " +
        "<span class='state'>" + suburb.state + "</span> " +
      "</a>" +
    "</li>";
}
