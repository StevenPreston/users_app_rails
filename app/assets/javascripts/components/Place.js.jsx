var Place = React.createClass({
  propTypes: {
    place: React.PropTypes.object
  },
  render: function() {
    var place = this.props.place;
    return (
      <div className='place-row-item'>
        {place.name} {place.formatted_address}
      </div>
    );
  }
});

module.exports = Place;
