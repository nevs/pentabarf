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

