// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

// replace pattern with substitute in attributes
// recursively on all child nodes of element
function attribute_replace( element, pattern, substitute, attributes ) {
  if ( ! attributes ) attributes = ['id','name','onchange'];
  for( var k = 0; k < attributes.length; k++ ) {
    if ( element.getAttribute( attributes[k] ) ) {
      element.setAttribute( attributes[k], element.getAttribute( attributes[k] ).replace( pattern, substitute ) );
    }
  }
  if ( element.nodeName.toLowerCase() != 'select' ) {
    var nodes = $(element).immediateDescendants();
    for( var i = 0; i < nodes.length; i++ ) {
      attribute_replace( nodes[i], pattern, substitute, attributes );
    }
  }
}

function enable_save_button() {
  Element.show( 'buttons' );
  window.onbeforeunload = unloadMessage;
}

function clear_tainting() {
  window.onbeforeunload = null;
}

function unloadMessage() {
  return "If you leave this page, your changes will be lost.";
}

var tabs = new Array();

// find all tabs
function find_tabs() {
  var nodes = $('tabs').descendants();
  var outer;
  for( var i = 0; i < nodes.length; i++){
    outer = nodes[i];
    if( outer.nodeName.toLowerCase() == "span" && $( outer.id.replace('tab-', 'content-') ) ) {
      tabs.push( outer.id.replace('tab-', '') );
    }
  }
}

// switch between tabs
function switch_tab( target ) {
  if ( tabs.length == 0 ) find_tabs();
  var realm = tab_realm();
  if ( target && realm )
    cookie_write( realm, target );

  if (!target && realm ) {
    if ( document.location.hash.length > 0 )
      target = document.location.hash.replace('#','');
    else
      target = cookie_read( realm );
  }

  if ( target == 'all' )
    return show_all_tabs();

  if (!target || tabs.indexOf(target) == -1 )
    target = tabs[0];

  for( var i = 0; i < tabs.length; i++) {
    $( 'tab-' + tabs[i] ).setAttribute('class','tab inactive');
    Element.hide( 'content-' + tabs[i] );
  }
  $( 'tab-' + target ).setAttribute('class','tab active');
  Element.show( 'content-' + target );
}

function show_all_tabs() {
  var realm = tab_realm();
  if ( realm )
    cookie_write( realm, 'all' );

  for( var i = 0; i < tabs.length; i++) {
    $( 'tab-' + tabs[i] ).setAttribute('class','tab active');
    Element.show( 'content-' + tabs[i] );
  }
}


var table_row_counter = {};

// add another row to a table by copying a template row
function table_add_row( table_name ) {
  var row_id = table_row_counter[table_name];
  if (!row_id) {
    table_find_fields( table_name );
    row_id = $(table_name + '_tbody').rows.length - 1;
  }
  table_row_counter[table_name] = row_id + 1;

  var prefix = table_name + '[' + row_id + ']';
  var new_row = $(table_name + '_template').cloneNode(true);

  new_row.id = '';
  attribute_replace( new_row, /\[row_id\]/g, '[' + row_id + ']' );
  $(table_name + '_tbody').appendChild( new_row );
  Element.show( table_name + '_table' );
  Element.show( new_row );

  if (arguments.length > 1) {
    var field_names = table_fields[table_name];
    for( var i = 1; i < arguments.length; i++ ) {
      var field = $( prefix + '[' + field_names[ i - 1] + ']' );
      if (field.type == "checkbox") {
        if (arguments[i] != null)
          field.checked = arguments[i];
      } else {
        if (arguments[i] == null)
          arguments[i] = ''
        field.value = arguments[i];
      }
      if ( field.onchange ) {
        field.onchange();
      }
    }
  } else {
    var field_names = table_fields[table_name];
    for ( var i = 0; i < field_names.length; i++ ) {
      var col_name = prefix + '[' + field_names[i] + ']';
      var col = $( col_name );
      if ( col.nodeName.toLowerCase() == 'select' && col.onchange ) {
        col.onchange();
      }
    }
    enable_save_button();
  }
}

var table_fields = {};

// find field names of the fields of a table by iterating
// over the template row
function table_find_fields( table_name ) {
  var cells = $(table_name + '_template').cells;
  var fields = new Array();
  for (var i = 0; i < cells.length; i++) {
    var children = cells[i].descendants();
    for (var j = 0; j < children.length; j++) {
      var node = children[j].nodeName.toLowerCase();
      if ( node == "input" || node == "select" ) {
        var name = children[j].name;
        name = name.replace( /^[a-z_]+\[row_id\]\[([a-z_]+)\]$/, "$1" );
        if ( name != "remove" ) {
          fields.push( name );
        }
      }
    }
  }
  table_fields[table_name] = fields;
}

// adjust contents of slave select according to change in master select
function master_change( select, slave_column ) {
  var master_column = select.id.replace( /^.*\[([a-z_]+)\]$/, "$1" );
  var slave_id = select.id.replace( master_column, slave_column );
  var all_opts = $( slave_init( slave_id ) ).options;
  var slave = $( slave_id );
  var slave_value = slave.value;
  var real_value = null;
  slave.options.length = 0;
  for ( var i = 0; i < all_opts.length; i++ ) {
    if ( all_opts[i].className == select.value ) {
      if (slave_value == all_opts[i].value || !real_value)
        real_value = all_opts[i].value;
      slave.options[slave.options.length] = all_opts[i].cloneNode(true);  
    }
  }
  slave.value = real_value;
  if ( slave.options.length == 0 )
    slave.hide();
  else
    slave.show();
}

function slave_init( slave_id ) {
  var all_opts_id = slave_id.replace(/\[\d+\]/,'[row_id]') + '[all_opts]';
  if ( !$( all_opts_id ) ) {
    var all_opts = $(slave_id).cloneNode(true);
    all_opts.hide();
    all_opts.disabled = true;
    all_opts.name = "";
    all_opts.id = all_opts_id;
    $(slave_id).parentNode.appendChild( all_opts );
  }
  return all_opts_id;   
}

function init_search_list( list ) {
  var target = $( list );
  var template_row = $('search_template').getElementsBySelector('li')[0];
  var selector = template_row.getElementsBySelector('select')[0];
  var content = $('search_content').getElementsBySelector('li');
  for (var i = 0; i < content.length; i++ ) {
    var new_entry = document.createElement('option');
    new_entry.text = content[i].title;
    new_entry.value = content[i].className;
    selector.add( new_entry, null );
  }
}

var search_row_counter = 0;
function search_row_add( list, key, value ) {
  var template_row = $('search_template').getElementsBySelector('li')[0];
  var new_row = template_row.cloneNode(true);
  var row_id = search_row_counter;
  search_row_counter++;

  attribute_replace( new_row, /\[row_id\]/g, '[' + row_id + ']' );
  new_row.className = row_id;
  $('advanced_search_list').appendChild( new_row );
  if ( key && value ) {
    $( new_row ).getElementsBySelector('select')[0].value = key;
    $( new_row ).getElementsBySelector('select')[0].onchange();

    // FIXME
    if ( $( new_row ).getElementsBySelector('select')[1] )
      $( new_row ).getElementsBySelector('select')[1].value = value;
    else
      $( new_row ).getElementsBySelector('input')[1].value = value;
  } else {
    $( new_row ).getElementsBySelector('select')[0].onchange();
  }
}

function search_row_remove( list ) {
  if ( $(list).up().up().childElements().length > 1 ) {
    $(list).up().remove();
  }
}

function search_row_change( list ) {
  var row = $(list).up();
  var row_id = row.className;
  var value = row.getElementsBySelector('select')[0].getValue();
  var target = row.getElementsBySelector('span.dynamic')[0];

  // remove old content
  var old_stuff = target.immediateDescendants();
  for ( var i = 0; i < old_stuff.length; i++ ) { Element.remove( old_stuff[i] ); }

  // add new content
  var content = $('search_content').getElementsBySelector('li.' + value)[0].immediateDescendants();
  for ( var i = 0; i < content.length; i++ ) {
    target.appendChild( content[i].cloneNode( true ) );
  }
  attribute_replace( target, /\[row_id\]/, '[' + row_id + ']' );
}

function set_boxes( button, value ) {
  var row = $(button).up().up();
  var boxes = row.getElementsBySelector('input');
  for (var i=0; i < boxes.length; i++) {
    boxes[i].checked = value;
  }
  enable_save_button();
}

// guesses tab realm for current location
function tab_realm() {
  var uri = document.location.pathname;
  var result = /.*\/(pentabarf|submission)\/([a-zA-Z]+)/.exec( uri );
  var realm = null;
  if ( !result || result[0] == "" )
    realm = "index";
  else
    realm = result[1] + '_' + result[2];
  return realm;
}

// creates/saves a cookie
function cookie_write( name, value ) {
  var date = new Date();
  date.setTime(date.getTime()+6*30*60*60*24*1000); //cookie valid for 6 months
  document.cookie = name + "=" + value + "; expires="+date.toGMTString()+"; path=/";
}

//reads data stored in the cookie
function cookie_read( name ) {
  name = name + "=";
  if ( document.cookie ) {
    var cookies = document.cookie.split( ';' );
    for( var i=0; i < cookies.length; i++ ) {
      var c = cookies[i];
      while ( c.charAt(0) == ' ') c = c.substring( 1, c.length);
      if ( c.indexOf( name ) == 0) return c.substring( name.length, c.length );
    }
  }
  return null;
}

function replace_element_with_hidden_field( element ) {
  var hidden = document.createElement('input');
  hidden.type = 'hidden';
  hidden.name = element.name;
  hidden.id = element.id;
  hidden.value = $F( element );
  element.parentNode.appendChild( hidden );
  Element.remove( element );
}

function add_event_person( current_transaction_id, event_person_id, person_id, event_role, event_role_state, remark ) {
  table_add_row( 'event_person', current_transaction_id, event_person_id, person_id, event_role, event_role_state, remark );
  var index = table_row_counter['event_person'] - 1;
  var select = $('event_person[' + index + '][person_id]');
  var link = document.createElement('a');
  link.href = document.URL.replace( /event\/edit\/\d+(#.*)?/, 'person/edit/' + select.value );
  link.appendChild( document.createTextNode( select.options[select.selectedIndex].text ) );
  select.parentNode.appendChild( link );
  replace_element_with_hidden_field( select );
}

function add_conference_day(current_transaction_id,conference_day_id,conference_day,name,public) {
  table_add_row( 'conference_day', current_transaction_id, conference_day_id, conference_day, name, public );
  var index = table_row_counter['conference_day'] - 1;
  Calendar.setup({inputField:'conference_day['+index+'][conference_day]',ifFormat:'%Y-%m-%d',button:'conference_day['+index+'][conference_day_button]',showOthers:true,singleClick:false,onUpdate:enable_save_button});
}

function rename_valuelist_local( valuelist ) {
  var row_id = $( valuelist + '_rename[old_name]').selectedIndex;
  var new_value = $F( valuelist + '_rename[new_name]');
  $( valuelist + '[' + row_id + '][' + valuelist + ']').value = new_value;
  var td = $( valuelist + '[' + row_id + '][' + valuelist + ']').parentNode;
  var nodes = td.childNodes;
  for ( i = 0; i < nodes.length; i++ ) {
    if ( nodes[i].nodeType == Node.TEXT_NODE ) td.removeChild( nodes[i] );
  }
  td.appendChild( document.createTextNode( new_value ) );
  $( valuelist + '_rename[old_name]').options[row_id].value = new_value;
  $( valuelist + '_rename[old_name]').options[row_id].textContent = new_value;
  $( valuelist + '_rename[new_name]').value = '';
}

function logout() {
  new Ajax.Request(window.location.href,{on403:function(){window.location.href = '/logout'},requestHeaders:{Authorization: 'Basic '+Base64.encode('logout:logout')}});
}


