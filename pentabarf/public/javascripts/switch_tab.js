
function switch_tab( tag ) {

  var page_url = document.location.href;
  
  if ( !tag && page_url.search('#') != -1 ) {
    tag = page_url.slice(page_url.search('#') + 1,page_url.length);
    page_url = page_url.slice(0,page_url.search('#'));
  }
  
  // get variable name for cookie index
  var cookieVarNameFilter = /^.*\/pentabarf\/([a-zA-Z0-9-_]+)\/.*$/;
  cookieVarNameFilter.exec(page_url);
  
  var realm = '';
  if (RegExp.$1 == "") {
    realm = "home";
  } else {
    realm = RegExp.$1;
  }
  if (!tag) { // if tag is empty then read data from cookie - init
    tag = readCookieVar(realm);
  }

  if (tag != 'all') {
    // search whether tag is a valid tab
    var found = false;
    var key;
    for (key in tab_name) {
      if (tab_name[key] == tag){
        found = true;
        break;
      }
    }
    if (!found) tag = tab_name[0];
  }

  //write data to the cookie
  setCookieVar(realm, tag);
  
  // display selected content for the selected and hide content of other tabs
  for (var i = 0; i < tab_name.length && document.getElementById("tab-"+tab_name[i]); i++) {
    if (tag == tab_name[i] || tag == "all") {
      if (document.getElementById("content-"+tab_name[i])) {
        document.getElementById("content-" + tab_name[i]).style.display = "block";
      }
      document.getElementById("tab-" + tab_name[i]).setAttribute("class","tab active");
    } else {
      if (document.getElementById("content-"+tab_name[i])) {
        document.getElementById("content-" + tab_name[i]).style.display = "none";
      }
      document.getElementById("tab-" + tab_name[i]).setAttribute("class","tab inactive");
    }
  }
  if (tag == "all" && document.getElementById("tab-all")) {
    document.getElementById("tab-all").setAttribute("class", "tab active");
  } else if ( document.getElementById("tab-all") ) {
    document.getElementById("tab-all").setAttribute("class", "tab inactive");
  }
}
