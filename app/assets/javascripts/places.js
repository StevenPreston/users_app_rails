var pageLoad = function () {
  var weddingLocation = document.getElementById('place_location');
  var autoComplete = new google.maps.places.Autocomplete(weddingLocation);

  google.maps.event.addListener(autoComplete, 'place_changed', function() {
    var place = autoComplete.getPlace();
    var name = place.name;
    var utc_offset = place.utc_offset;
    var formatted_address = place.formatted_address;


    var nameField = document.getElementById('place_name');
    nameField.value = name;

    var addressField = document.getElementById('place_formatted_address');
    addressField.value = formatted_address;
  });
}

$(document).ready(pageLoad);
$(document).on('page:load', pageLoad);
