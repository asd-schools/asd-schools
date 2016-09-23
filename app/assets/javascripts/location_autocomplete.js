
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
  template = searchConfig.ToText;
  template = searchConfig.ToUrl;
  template = function(r) {
    var result = document.createElement('a');
    $(result).attr('href', searchConfig.ToUrl(r));
    result.innerText = searchConfig.ToText(r);
    return result;
  }
  var f = $(form)
  var ul = $(output)

  $(input).on('keypress', function onKeyPress(e) {
    if (e.keyCode === 13) {
      output.children()[0] && output.children()[0].click()
      e.preventDefault();
    }
  });

  $(input).on('input', function onSuburbChange(inputEvent) {
    datasource(inputEvent.target.value, function setContent(content) {
      ul.empty();

      content.slice(0, 10).forEach(function(record) {
        var node = template(record);
        node.classList.add("autocomplete-result");

        if (onSelect) {
          $(node).click(function onClickAutocomplete(clickEvent) {
            if (clickEvent.button === 0) {
              clickEvent.preventDefault();
            }
            $(input).val(searchConfig.ToText(record))
            onSelect(record, f);

            ul.empty();
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

function SchoolToText(suggestion) {
  return suggestion.name + " (" + suggestion.suburb + ", " + suggestion.school_type + ")";
}
function SchoolToUrl(suggestion) {
  return "/schools/" + encodeURIComponent(suggestion.id)
}

function ConsumerSuggestToText(suggestion) {
  return suggestion.display.text;
}

function ConsumerSuggestToUrl(suggestion) {
  return "/searches/?search[atlas_id]=" + encodeURIComponent(suggestion.id.slice(0, 36))
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

function ConsumerSuggestOnSelect(record, f) {
  if (record.id) {
    f.find('[name="search[atlas_id]"]').val(record.id.slice(0, 36))
  }
  if (record.point) {
    f.find('[name="search[lat]"]').val(record.point.x)
    f.find('[name="search[lng]"]').val(record.point.y)
  }
  f.submit()
}

School = {
  Autocomplete: SchoolAutocomplete,
  OnSelect: function(e) {window.location = "/schools/"+e.id},
  ToText: SchoolToText,
  ToUrl: SchoolToUrl
};

ConsumerSuggest = {
  Autocomplete: ConsumerSuggestAutocomplete,
  OnSelect: ConsumerSuggestOnSelect,
  ToText: ConsumerSuggestToText,
  ToUrl: ConsumerSuggestToUrl
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
    ToText: function(record) {
      if (record.__combiner_source == first) {
        return first.ToText(record)
      } else {
        return second.ToText(record)
      }
    },
    ToUrl: function(record) {
      if (record.__combiner_source == first) {
        return first.ToUrl(record)
      } else {
        return second.ToUrl(record)
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
