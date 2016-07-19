var CreatePlace = React.createClass({
  propTypes: {

  },
  render: function() {

    return (
      <form id="add-place-form" action="/users/1/places" acceptCharset="UTF-8" method="post">
        <input name="utf8" type="hidden" value="✓"/>
        <input type="hidden" name="authenticity_token" value="NgpdJOoO/2pbzf7Z82g7vjCr5f20Ot9oKUddXayczkPHJVVkAjE21x46TrjZvel1DAng1l1Yq4wXxdQ5NzHUfg=="/>
        <div className="hidden">
          <input type="text" name="place[name]" id="place_name"/>
          <input type="text" name="place[formatted_address]" id="place_formatted_address"/>
          <input type="text" name="place[lat]" id="place_lat"/>
          <input type="text" name="place[lng]" id="place_lng"/>
        </div>

        <div className="input-group add-places">
          <input type="submit" name="commit" value="Add Place" className="hidden" data-disable-with="Add Place"/>
          <input type="date" name="date" id="date" className="add-place-date-field hidden"/>
          <input type="text" name="place_location" id="place_location" placeholder="Place" className="add-place-place-field" autoComplete="off"/>
        </div>
      </form>
    );
  }
});

module.exports = CreatePlace;
