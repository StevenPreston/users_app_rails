import React, { Component, PropTypes } from 'react'
import { connect } from 'react-redux'
import { fetchPlacesIfNeeded, invalidatePlaces } from '../actions'

class AsyncApp extends Component {
  constructor(props) {
    super(props)
    //this.handleChange = this.handleChange.bind(this)
    this.handleRefreshClick = this.handleRefreshClick.bind(this)
  }

  componentDidMount() {
    const { dispatch } = this.props
    dispatch(fetchPlacesIfNeeded())
  }

  /*componentWillReceiveProps(nextProps) {
    if (nextProps.selectedSubreddit !== this.props.selectedSubreddit) {
      const { dispatch, selectedSubreddit } = nextProps
      dispatch(fetchPostsIfNeeded(selectedSubreddit))
    }
  }*/

  /*handleChange(nextSubreddit) {
    this.props.dispatch(selectSubreddit(nextSubreddit))
  }*/

  handleRefreshClick(e) {
    e.preventDefault()

    const { dispatch } = this.props
    dispatch(invalidatePlaces())
    dispatch(fetchPlacesIfNeeded())
  }

  render() {
    const { places, isFetching, lastUpdated } = this.props
    return (
      <div>
        <p>
          {lastUpdated &&
            <span>
              Last updated at {new Date(lastUpdated).toLocaleTimeString()}.
              {' '}
            </span>
          }
          {!isFetching &&
            <a href='#' onClick={this.handleRefreshClick}> Refresh </a>
          }
        </p>
        {isFetching && places.length === 0 &&
          <h2>Loading...</h2>
        }
        {!isFetching && places.length === 0 &&
          <h2>Empty.</h2>
        }
        {places.length > 0 &&
          <div style={{ opacity: isFetching ? 0.5 : 1 }}>
            <Places places={places} />
          </div>
        }
      </div>
    )
  }
}

AsyncApp.propTypes = {
  places: PropTypes.array.isRequired,
  isFetching: PropTypes.bool.isRequired,
  lastUpdated: PropTypes.number,
  dispatch: PropTypes.func.isRequired
}

function mapStateToProps(state) {
  const {
    isFetching,
    lastUpdated,
    items: places
  } = state || {
    isFetching: true,
    items: []
  }

  return {
    places,
    isFetching,
    lastUpdated
  }
}

module.exports = connect(mapStateToProps)(AsyncApp)
