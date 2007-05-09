
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

