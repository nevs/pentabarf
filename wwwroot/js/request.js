/**
*
* @Author: Mike Hostetler <mike@tm-web.com>, Bastian Müller <turbo24prg@c3d2.de>
* @Version: 0.2
* 
*/

//Start phpRequest Object
function phpRequest(server_url) {
  this.parms = new Array();
  this.parmsIndex = 0;
  this.execute = phpRequestExecute;
  this.add = phpRequestAdd;
  this.server = server_url;
  this.method = "";
}

function phpRequestAdd(name,value) {
  this.parms[this.parmsIndex] = new Pair(name,value);
  this.parmsIndex++;
}

function phpRequestExecute() {
  var targetURL = this.server;
  
  try {
    var httpRequest = new XMLHttpRequest();
  }catch (e){
    alert('Error creating the connection!');
    return;
  }
  
  try {
    var txt="";
    for(var i in this.parms) {
      if (txt.length) txt = txt+'&';
      txt = txt+this.parms[i].name+'='+this.parms[i].value; 
    }
    if(this.method=="get") {
      //GET REQUEST
      httpRequest.open("GET", targetURL+'?'+txt, false);
      httpRequest.send('');  
    }
    if(this.method=="post") {
      //POST REQUEST
      httpRequest.open("POST", targetURL, false);  
      httpRequest.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
      httpRequest.send(txt);
    }

  }catch (e){
    alert('An error has occured calling the external site: '+e);
    return false;
  } 

  switch(httpRequest.readyState) {
    case 1,2,3:
      alert('Bad Ready State: '+httpRequest.status);
      return false;
    break;
    case 4:
      if(httpRequest.status !=200) {
        alert('The server respond with a bad status code: '+httpRequest.status);
        return false;
      } else {
        var response = httpRequest.responseText;
      }
    break;
  }
  
  return response;
}

function Pair(name,value) {
  this.name = name;
  this.value = value;
}
