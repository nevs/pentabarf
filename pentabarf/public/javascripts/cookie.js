// creates/saves a cookie 
function createCookie(name, value) {
  var date = new Date();
  date.setTime(date.getTime()+365*60*60*24*1000); //cookie valid for 1 year from today
  document.cookie = name + "=" + value + "; expires="+date.toGMTString()+"; path=/";
}

//reads data stored in the cookie
function readCookie(name) {
  var start = document.cookie.indexOf(name+"=");
  var ende = document.cookie.indexOf(";") == -1 ? document.cookie.length : document.cookie.indexOf(";");
  return document.cookie.substring(start+name.length+1, ende);
}

//checks if a variable name exists in the data area
function issetCookieVar(name) {
  var data = readCookie("Pentabarf");
  var pattern = eval("/:" + name + "=[a-z0-9-_]+:/i");
  return pattern.test(data);
}

//reads the value of a variable
function readCookieVar(name) {
  if (issetCookieVar(name)) {
    data = readCookie("Pentabarf");
    kvarray = data.split(":");
    for (i = 0; i < kvarray.length; i++) {
      varArray = kvarray[i].split("=");
      if (varArray[0] == name)
        return varArray[1];
    } 
  } 
  return "";
}

//saves a value under name "name" to the cookie
function setCookieVar(name, value) {
  var data = readCookie("Pentabarf");
  var pattern = eval("/:" + name + "=[a-z0-9-_]+:/i");
  var repl = ":" + name + "=" + value + ":";
  if (pattern.test(data) == true) {
    data = data.replace(eval("/:" + name + "=[a-z0-9-_]+:/i"), repl);
  } else {
    data = repl + data;
  }
  createCookie("Pentabarf", data);
}
