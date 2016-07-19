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
    places: json.data.children.map(child => child.data),
    receivedAt: Date.now()
  }
}

function fetchPlaces() {
  return dispatch => {
    dispatch(requestPlaces())

    var request = new Request('/users/1/places.json', {
      headers: new Headers({
        'Set-Cookie': '_users_app_session=NFo3dFdMOHEwNnpUbHFibFhNS1M5bHNtNnBsM1F1ZEsxR2VUT3ExRUJZL2lqL3hvemFOY2x3U0pWY1U4VHNaVWd1dCtXY3VKOTMrdTFIUXdvdXppSksyU21zZm13VytoRXJlMXRwZms1ZUVQV01Lb2xMenJwclhaWE5ac0tBcTQvQlNEd05YdWhiOTA4Y0Z3NkE4QkdlQ3JmZEN6ZmlGQVAxZ3c1S0NJVjg0PS0tSmNGczZSZE5YQkNaeUlNNGpMRmsvQT09'
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
