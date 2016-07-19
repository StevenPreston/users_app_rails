// Tell react-rails where our components are
//= require_tree ./components
//= require_tree ./containers

window.Place = global.Place = require('./components/Place');
window.CreatePlace = global.CreatePlace = require('./components/CreatePlace');
window.Places = global.Places = require('./components/Places');
window.AsyncApp = global.AsyncApp = require('./containers/AsyncApp');
window.Root = global.Root = require('./containers/Root');
