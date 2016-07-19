var pageLoad = function () {
  var weddingLocation = document.getElementById('place_location');
  var autoComplete = new google.maps.places.Autocomplete(weddingLocation);

  google.maps.event.addListener(autoComplete, 'place_changed', function() {
    var place = autoComplete.getPlace();
    var name = place.name;
    var utc_offset = place.utc_offset;
    var formatted_address = place.formatted_address;
    var lng = place.geometry.location.lng();
    var lat = place.geometry.location.lat();

    $('#place_name').val(name);
    $('#place_formatted_address').val(formatted_address);
    $('#place_lat').val(lat);
    $('#place_lng').val(lng);

    $('#place_location').val('');
    $('#add-place-form').submit();
  });

  $('#add-place-form').submit(function() {
    var name = $('#place_name').value;
    if (name) {
      var nameLength = $('#place_name')[0].value.trim().length;

      if (nameLength === 0) {
        return false;
      } else {
        return true;
      }
    }
  });

  $('#place_location').keyup(function() {
    $('#place_name').val('');
    $('#place_formatted_address').val('');
    $('#place_lat').val('');
    $('#place_lng').val('');
  });
}

$(document).ready(pageLoad);
$(document).on('page:load', pageLoad);
