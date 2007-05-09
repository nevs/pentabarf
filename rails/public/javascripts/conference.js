
// add a language to the list of conference languages
var conference_language_counter = 0;

function add_conference_language( conference_language_id, language_id ) {
  var row_id = conference_language_counter++;
  var prefix = 'conference_language[' + row_id + ']';
  var new_row = $('conference_language_template').cloneNode(true);

  new_row.id = '';
  attribute_replace( new_row, /\[row_id\]/g, '[' + row_id + ']' );
  $('conference_language_tbody').appendChild( new_row );
  Element.show( 'conference_language_table' );
  Element.show( new_row );

  if ( conference_language_id )
    $( prefix + '[conference_language_id]' ).value = conference_language_id;
  else
    enable_save_button();

  if ( language_id ) $( prefix + '[language_id]' ).value = language_id;

}

// add a team to the list of conference teams
var conference_team_counter = 0;

function add_conference_team( conference_team_id, tag ) {
  var row_id = conference_team_counter++;
  var prefix = 'conference_team[' + row_id + ']';
  var new_row = $('conference_team_template').cloneNode(true);

  new_row.id = '';
  attribute_replace( new_row, /\[row_id\]/g, '[' + row_id + ']' );
  $('conference_team_tbody').appendChild( new_row );
  Element.show( 'conference_team_table' );
  Element.show( new_row );

  if ( conference_team_id )
    $( prefix + '[team_id]' ).value = conference_team_id;
  else
    enable_save_button();

  if ( tag ) $( prefix + '[tag]' ).value = tag;

}

// add a track to the list of conference tracks
var conference_track_counter = 0;

function add_conference_track( conference_track_id, tag ) {
  var row_id = conference_track_counter++;
  var prefix = 'conference_track[' + row_id + ']';
  var new_row = $('conference_track_template').cloneNode(true);

  new_row.id = '';
  attribute_replace( new_row, /\[row_id\]/g, '[' + row_id + ']' );
  $('conference_track_tbody').appendChild( new_row );
  Element.show( 'conference_track_table' );
  Element.show( new_row );

  if ( conference_track_id )
    $( prefix + '[conference_track_id]' ).value = conference_track_id;
  else
    enable_save_button();

  if ( tag ) $( prefix + '[tag]' ).value = tag;

}

// add a room to the list of conference rooms
var conference_room_counter = 0;

function add_conference_room( conference_room_id, tag, rank, size, f_public ) {
  var row_id = conference_room_counter++;
  var prefix = 'conference_room[' + row_id + ']';
  var new_row = $('conference_room_template').cloneNode(true);

  new_row.id = '';
  attribute_replace( new_row, /\[row_id\]/g, '[' + row_id + ']' );
  $('conference_room_tbody').appendChild( new_row );
  Element.show( 'conference_room_table' );
  Element.show( new_row );

  if ( conference_room_id )
    $( prefix + '[room_id]' ).value = conference_room_id;
  else
    enable_save_button();

  if ( tag ) {
    $( prefix + '[short_name]' ).value = tag;
    $( prefix + '[rank]' ).value = rank;
    $( prefix + '[size]' ).value = size;
    $( prefix + '[f_public]' ).value = f_public;
  }

}

