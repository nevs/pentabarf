
// add a language to the list of person languages
var person_language_counter = 0;

function add_person_language( language_id ) {
  var row_id = person_language_counter++;
  var prefix = 'person_language[' + row_id + ']';
  var new_row = $('person_language_template').cloneNode(true);

  new_row.id = '';
  attribute_replace( new_row, /\[row_id\]/g, '[' + row_id + ']' );
  $('person_language_tbody').appendChild( new_row );
  Element.show( 'person_language_table' );
  Element.show( new_row );

  if ( language_id )
    $( prefix + '[language_id]' ).value = language_id;
  else
    enable_save_button();

}

