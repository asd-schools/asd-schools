
function BrowserGeocode() {
  navigator.geolocation.getCurrentPosition(function gotGeocode(geocode) {
    window.location = "/search/?lat=" +
      encodeURIComponent(geocode.coords.latitude) +
      "&lng=" +
      encodeURIComponent(geocode.coords.longitude)
  });
}

function SuburbAutocomplete(
  form,
  input,
  output,
  datasource,
  template
) {
  var f = $(form)
  var ul = $(output)

  var defaultAnswer = null;

  f.submit(function finishAutocomplete() {
    if (defaultAnswer) {
      onSelect(defaultAnswer);
    }
  })

  function onSelect(record) {
    defaultAnswer = null;
    if (record.id) {
      f.find('[name="search[atlas_id]"]').val(record.id.slice(0, 36))
    }
    if (record.point) {
      f.find('[name="search[lat]"]').val(record.point.x)
      f.find('[name="search[lng]"]').val(record.point.y)
    }
    ul.empty();
    $(input).val(" " + (record.name || record.display.text))
  }

  $(input).on('input', function onSuburbChange(inputEvent) {
    datasource(inputEvent.target.value, function setContent(content) {
      ul.empty();

      defaultAnswer = content[0];
      content.slice(0, 10).forEach(function(record) {
        var node = template(record);
        node.classList.add("autocomplete-result");

        $(node).click(function onClickAutocomplete(clickEvent) {
          clickEvent.preventDefault();
          onSelect(record);
        })
        ul[0].appendChild(node)
      })
    });
  })
}

function GistSuburbAutocomplete(input, cb) {
  $.getJSON(
    "/suburbs?q="+encodeURIComponent(input)
  ).then(cb);
}

function ConsumerSuggestAutocomplete(input, cb) {
  var baseUrl = "https://suggest.realestate.com.au/consumer-suggest/suggestions";

  $.getJSON({
    url: baseUrl + "?max=20&src=autism-schools-reaio&type=suburb,region,precinct,postcode&query=" + encodeURIComponent(input),
  }).then(function suburbAutocompleteResponse(response) {
    cb(response._embedded.suggestions);
  }, function errorCallback(response) {
    console.log("error", response);
  });
}

function ConsumerSuggestTemplate(suggestion) {
  var result = document.createElement('a')
  $(result).attr('href', "/searches/?search[atlas_id]=" + encodeURIComponent(suggestion.id.slice(0, 36)));
  result.innerText = suggestion.display.text;
  return result;
}

function GistSuburbTemplate(suburb) {
  var result = document.createElement('a')
  $(result).attr(
    'href',
    "/searches/?search[lat]=" + encodeURIComponent(suburb.point.x) +
    "&search[lng]=" + encodeURIComponent(suburb.point.y)
  );
  result.innerHTML = "" +
    "<span class='suburbname'>" + suburb.name + "</span> " +
    "<span class='postcode'>" + suburb.postcode + "</span> " +
    "<span class='state'>" + suburb.state + "</span> ";

  return result;
}
