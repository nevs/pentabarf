// creates/saves a cookie 
function createCookie(name, value) {
  date = new Date();
  date.setTime(date.getTime()+365*60*60*24*1000); //cookie valid for 1 year from today
  document.cookie = name + "=" + value + "; expires="+date.toGMTString()+"; path=/";
}

//reads data stored in the cookie
function readCookie(name) {
  start = document.cookie.indexOf(name+"=");
  ende = document.cookie.indexOf(";") == -1 ? document.cookie.length : document.cookie.indexOf(";");
  return document.cookie.substring(start+name.length+1, ende);
  //pattern = eval("/"+name+"=([a-zA-Z0-9-_:=]+);*/");
  //pattern.exec(document.cookie);
  //return RegExp.$1;
}

//checks if a variable name exists in the data area
function issetCookieVar(name) {
  data = readCookie("Pentabarf");
  pattern = eval("/:" + name + "=[a-z0-9-_]+:/i");
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
  } else {
    return "";
  }
}

//saves a value under name "name" to the cookie
function setCookieVar(name, value) {
  data = readCookie("Pentabarf");
  pattern = eval("/:" + name + "=[a-z0-9-_]+:/i");
  repl = ":" + name + "=" + value + ":";
  if (pattern.test(data) == true) {
    data = data.replace(eval("/:" + name + "=[a-z0-9-_]+:/i"), repl);
  } else {
    data = repl + data;
  }
  createCookie("Pentabarf", data);
}
