function suburbAutocomplete(selector) {

  var ul = document.createElement("ul")
  $(selector).after(ul)
  $(selector).on('input', function onSuburbChange(ev) {
    $.getJSON(
      "/suburbs?q="+encodeURIComponent(ev.target.value)
    ).then(function onSuburbJsonLoaded(suburbs) {
      ul.innerHTML = suburbs.map(function suburbTemplate(suburb) {
        return "" +
          "<li class='autocomplete-result'>" +
            "<a href='/search/?lat=" + suburb.point.x + "&lng=" + suburb.point.y + "'>" +
              "<span class='suburbname'>" + suburb.name + "</span> " +
              "<span class='postcode'>" + suburb.postcode + "</span> " +
              "<span class='state'>" + suburb.state + "</span> " +
            "</a>" +
          "</li>"
      }).join("")
    })
  })

}
