import { createStore, applyMiddleware } from 'redux'
import thunkMiddleware from 'redux-thunk'
import createLogger from 'redux-logger'
import React, { Component } from 'react'
import { Provider } from 'react-redux'
import placesReducer from '../reducers/reducers'

const loggerMiddleware = createLogger()

const store = createStore(placesReducer, { items: [], isFetching: true },
  applyMiddleware(
    thunkMiddleware,
    loggerMiddleware
  ))

var Root = React.createClass({
  render: function() {
    return (
      <Provider store={store}>
        <AsyncApp />
      </Provider>
    );
  }
});

module.exports = Root;
