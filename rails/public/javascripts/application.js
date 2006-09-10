// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function clear_tainting()
{
  window.onbeforeunload = null;
}

function enable_save_button()
{
  Element.show( 'buttons' );
  window.onbeforeunload = unloadMessage;
}

function unloadMessage()
{
  return "If you leave this page, your changes will be lost.";
}

var tabs = new Array();

// find all tabs
function find_tabs()
{
  var nodes = $('tabs').childNodes;
  var outer;
  for( var i = 0; i < nodes.length; i++){
    outer = nodes[i];
    if( outer instanceof HTMLSpanElement ) {
      tabs.push( outer.id.replace('tab-', '') );
    }
  }
}

// switch between tabs
function switch_tab( target )
{
  if ( tabs.length == 0 ) find_tabs();
  if (!target) target = tabs[0];
  for( var i = 0; i < tabs.length; i++) {
    $( 'tab-' + tabs[i] ).setAttribute('class','tab inactive');
    Element.hide( 'content-' + tabs[i] );
  }
  $( 'tab-' + target ).setAttribute('class','tab active');
  Element.show( 'content-' + target );
}

// hide options currently not suitable for selects with a hierarchy
// depending on the value of the master_field
// the corresponding master element to a slave element has to be set
// as class of the slave-option
function master_changed( master_field, slave_field, prefix ) {
  var expected = prefix + $F( master_field );
  var nodes = $( slave_field ).childNodes;
  var first = false;
  var valid = false;
  for( var i = 0; i < nodes.length; i++ ) {
    if ( nodes[i] instanceof HTMLOptionElement ) {
      if ( Element.hasClassName( nodes[i], expected ) ) {
        if ( first == false ) first = nodes[i].value;
        if ( $F( slave_field ) == nodes[i].value ) valid = true;
        Element.show( nodes[i] );
      } else {
        Element.hide( nodes[i] );
      }
    }
  }
  if ( ! valid ) $( slave_field ).value = first;
  if ( first ) {
    Element.show( slave_field );
  } else {
    Element.hide( slave_field );
    $( slave_field ).value = '';
  }
}

// replace pattern with substitute in attributes
// recursively on all child nodes of element
function attribute_replace( element, pattern, substitute, attributes ) {
  var nodes = element.childNodes;
  if ( ! attributes ) attributes = ['id','name','onchange'];
  for( var i = 0; i < nodes.length; i++ ) {
    var node = nodes[i];
    if ( node instanceof Element ) {
      for( var k = 0; k < attributes.length; k++ ) {
        if ( node.getAttribute( attributes[k] ) ) {
          node.setAttribute( attributes[k], node.getAttribute( attributes[k] ).replace( pattern, substitute ) );
        }
      }
      attribute_replace( node, pattern, substitute, attributes );
    }
  }
}

