import fetch from 'isomorphic-fetch'

export const REQUEST_PLACES = 'REQUEST_PLACES'
export const RECEIVE_PLACES = 'RECEIVE_PLACES'
export const INVALIDATE_PLACES = 'INVALIDATE_PLACES'

export function invalidatePlaces() {
  return {
    type: INVALIDATE_PLACES
  }
}

function requestPlaces() {
  return {
    type: REQUEST_PLACES
  }
}

function receivePlaces(json) {
  return {
    type: RECEIVE_PLACES,
    places: json.data ? json.data.children.map(child => child.data) : [],
    receivedAt: Date.now()
  }
}

function fetchPlaces() {
  return dispatch => {
    dispatch(requestPlaces())

    var request = new Request('/users/2/places.json', {
      headers: new Headers({
        'Authorization': 'Authorization: ' + getToken()
      })
    });

    return fetch(request)
      .then(response => response.json())
      .then(json => dispatch(receivePlaces(json)))
  }
}

function shouldFetchPlaces(state, places) {
  if (!places) {
    return true
  } else if (places.isFetching) {
    return false
  } else {
    return places.didInvalidate
  }
}

export function fetchPlacesIfNeeded() {
  return (dispatch, getState) => {
    if (shouldFetchPlaces(getState())) {
      return dispatch(fetchPlaces())
    }
  }
}

function getToken() {
  var name = '_app4_token' + '=';
  var ca = document.cookie.split(';');
  for (var i = 0; i < ca.length; i++) {
    var c = ca[i];
    while (c.charAt(0) === ' ') {
      c = c.substring(1);
    }
    if (c.indexOf(name) === 0) {
      return c.substring(name.length, c.length);
    }
  }
  return '';
}
