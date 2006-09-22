
// add a person to the table on the persons tab of the event page
var event_person_counter = 0;
function add_event_person( event_person_id, person_id, event_role, event_role_state, remark ) {
  var row_id = event_person_counter++;
  var prefix = 'event_person[' + row_id + ']';
  var new_row = $('event_person_template').cloneNode(true);

  new_row.id = '';
  attribute_replace( new_row, /\[row_id\]/g, '[' + row_id + ']' );
  $('event_person_tbody').appendChild( new_row );
  Element.show( 'event_person_table', new_row );

  if ( event_person_id ) {
    $( prefix + '[event_person_id]' ).value = event_person_id;
  } else {
    enable_save_button();
  }

  if ( person_id ) {
    $( prefix + '[person_id]' ).value = person_id;
    $( prefix + '[person_id]' ).setAttribute( 'disabled', 'disabled' );   
    $( prefix + '[person_id][hidden]' ).value = person_id;
    $( prefix + '[person_id][hidden]' ).removeAttribute( 'disabled' );   
    $( prefix + '[url]').setAttribute( 'href', $( prefix + '[url]' ).getAttribute( 'href' ).replace( /0$/, person_id ));
    $( prefix + '[image]').setAttribute( 'src', $( prefix + '[image]' ).getAttribute( 'src' ).replace( /0$/, person_id ));
  }
  if( event_role ) $( prefix + '[event_role]').value = event_role;
  if( event_role_state ) $( prefix + '[event_role_state]').value = event_role_state;
  if( remark ) $( prefix + '[remark]').value = remark;

  master_changed(  prefix + '[event_role]', prefix + '[event_role_state]', 'event_role_' );

}

