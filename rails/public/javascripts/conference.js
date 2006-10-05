
// add a person to the table on the persons tab of the event page
var conference_language_counter = 0;

function add_conference_language( conference_language_id, language ) {
  var row_id = conference_language_counter++;
  var prefix = 'conference_language[' + row_id + ']';
  var new_row = $('conference_language_template').cloneNode(true);

  new_row.id = '';
  attribute_replace( new_row, /\[row_id\]/g, '[' + row_id + ']' );
  $('conference_language_tbody').appendChild( new_row );
  Element.show( 'conference_language_table', new_row );

  if ( conference_language_id )
    $( prefix + '[conference_language_id]' ).value = conference_language_id;
  else
    enable_save_button();

  if ( language ) $( prefix + '[language]' ).value = language;

}

var conference_track_counter = 0;

function add_conference_track( conference_track_id, conference_track ) {
  var row_id = conference_track_counter++;
  var prefix = 'conference_track[' + row_id + ']';
  var new_row = $('conference_track_template').cloneNode(true);

  new_row.id = '';
  attribute_replace( new_row, /\[row_id\]/g, '[' + row_id + ']' );
  $('conference_track_tbody').appendChild( new_row );
  Element.show( 'conference_track_table', new_row );

  if ( conference_track_id )
    $( prefix + '[conference_track_id]' ).value = conference_track_id;
  else
    enable_save_button();

  if ( conference_track )
    $( prefix + '[conference_track]' ).value = conference_track;

}

var conference_room_counter = 0;

function add_conference_room( conference_room_id, conference_room, public ) {
  var row_id = conference_room_counter++;
  var prefix = 'conference_room[' + row_id + ']';
  var new_row = $('conference_room_template').cloneNode(true);

  new_row.id = '';
  attribute_replace( new_row, /\[row_id\]/g, '[' + row_id + ']' );
  $('conference_room_tbody').appendChild( new_row );
  Element.show( 'conference_room_table', new_row );

  if ( conference_room_id )
    $( prefix + '[conference_room_id]' ).value = conference_room_id;
  else
    enable_save_button();

  if ( conference_room ) $( prefix + '[conference_room]' ).value = conference_room;
  if ( public == 'true' ) $( prefix + '[public]' ).checked = true;

}


