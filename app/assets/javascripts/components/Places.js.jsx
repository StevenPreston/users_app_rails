var Places = React.createClass({
  propTypes: {
    places: React.PropTypes.array
  },
  render: function() {
    var placeComponents = this.props.places.map(function(place) {
      return <Place place={place} key={place.id}/>;
    });
    return (
      <div className='container'>
        <div className='row'>
          <div className='col-md-8 col-md-offset-2'>
            <h1>Your Places</h1>
            <CreatePlace />
            <div id='places'>
              <div>{placeComponents}</div>
            </div>
          </div>
        </div>
      </div>
    );
  }
});

module.exports = Places;
