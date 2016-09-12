
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
  searchConfig
) {
  datasource = searchConfig.Autocomplete;
  onSelect = searchConfig.OnSelect;
  template = searchConfig.Template;
  var f = $(form)
  var ul = $(output)

  var defaultAnswer = null;

  f.submit(function finishAutocomplete(e) {
    if (defaultAnswer) {
      onSelect(defaultAnswer, f);
      e.preventDefault();
    }
  })

  $(input).on('input', function onSuburbChange(inputEvent) {
    datasource(inputEvent.target.value, function setContent(content) {
      ul.empty();
      defaultAnswer = content[0];

      content.slice(0, 10).forEach(function(record) {
        var node = template(record);
        node.classList.add("autocomplete-result");

        if (onSelect) {
          $(node).click(function onClickAutocomplete(clickEvent) {
            if (clickEvent.button === 0) {
              clickEvent.preventDefault();
            }
            onSelect(record, f);

            ul.empty();
            defaultAnswer = null;
          })
        }

        ul[0].appendChild(node)
      })
    });
  })
}

function SchoolAutocomplete(input, cb) {
  var baseUrl = "/searches/";

  $.getJSON({
    url: "/searches?autocomplete=" + encodeURIComponent(input),
  }).then(function suburbAutocompleteResponse(response) {
    cb(response);
  }, function errorCallback(response) {
    console.log("error", response);
  });
}

function SchoolTemplate(suggestion) {
  var result = document.createElement('a')
  $(result).attr('href', "/schools/" + encodeURIComponent(suggestion.id));
  result.innerText = suggestion.name + " (" + suggestion.suburb + ", " + suggestion.school_type + ")";
  return result;
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

function ConsumerSuggestOnSelect(record, f) {
    if (record.id) {
      f.find('[name="search[atlas_id]"]').val(record.id.slice(0, 36))
    }
    if (record.point) {
      f.find('[name="search[lat]"]').val(record.point.x)
      f.find('[name="search[lng]"]').val(record.point.y)
    }
    $(input).val(" " + (record.name || record.display.text))
  }

function GistSuburbAutocomplete(input, cb) {
  $.getJSON(
    "/suburbs?q="+encodeURIComponent(input)
  ).then(cb);
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

School = {
  Autocomplete: SchoolAutocomplete,
  OnSelect: function(e) {window.location = "/schools/"+e.id},
  Template: SchoolTemplate
};

ConsumerSuggest = {
  Autocomplete: ConsumerSuggestAutocomplete,
  OnSelect: ConsumerSuggestOnSelect,
  Template: ConsumerSuggestTemplate
};

GistOfSuburbs = {
  Autocomplete: GistSuburbAutocomplete,
  OnSelect: ConsumerSuggestOnSelect, // yes, it work(ed)
  Template: GistSuburbTemplate
};

function combineSearches(first, second) {
  return {
    Autocomplete: function(input, cb) {
      var firstResult, secondResult;
      var mixer = function() {
        if (firstResult && secondResult) {
          firstResult.forEach(function(e) {e.__combiner_source = first});
          secondResult.forEach(function(e) {e.__combiner_source = second});
          var mixed = firstResult.concat(secondResult);
          firstResult = null;
          secondResult = null;
          cb(mixed);
        }
      }

      first.Autocomplete(input, function(result) {firstResult = result; mixer();})
      second.Autocomplete(input, function(result) {secondResult = result; mixer();})
    },
    OnSelect: function(record, form) {
      if (record.__combiner_source == first) {
        first.OnSelect(record, form)
      } else {
        second.OnSelect(record, form)
      }
    },
    Template: function(record) {
      if (record.__combiner_source == first) {
        return first.Template(record)
      } else {
        return second.Template(record)
      }
    }
  }
}

$(function onLoad() {
  if ($("#search-form")[0]) {
    SuburbAutocomplete(
      $("#search-form"),
      $("#suburbAutocomplete"),
      $("#autocompleteResults"),
      combineSearches(School, ConsumerSuggest)
    );
  }
})
