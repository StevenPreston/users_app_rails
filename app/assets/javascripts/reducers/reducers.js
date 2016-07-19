import {
  REQUEST_PLACES, RECEIVE_PLACES, INVALIDATE_PLACES
} from '../actions'

function placesReducer(state = {
  isFetching: false,
  didInvalidate: false,
  items: []
}, action) {
  switch (action.type) {
    case INVALIDATE_PLACES:
      return Object.assign({}, state, {
        didInvalidate: true
      })
    case REQUEST_PLACES:
      return Object.assign({}, state, {
        isFetching: true,
        didInvalidate: false
      })
    case RECEIVE_PLACES:
      return Object.assign({}, state, {
        isFetching: false,
        didInvalidate: false,
        items: action.places,
        lastUpdated: action.receivedAt
      })
    default:
      return state
  }
}

export default placesReducer
