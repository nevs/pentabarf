function redrag(root) {
    var offsets = new Array();

    var elems = root.getElementsByTagName("li");
    
    for (var i = 0; i < elems.length; i++) {
        Drag.init(elems[i].firstChild, elems[i], 0, 0, null, null);
        elems[i].onDrag = function(x,y,myElem) {
            // We're only really interested in the y value
            y = myElem.offsetTop;
            recalcOffsets();
            var pos = whereAmI(myElem);
            var elems = root.getElementsByTagName("li");
            if (pos != elems.length-1 && y > offsets[pos + 1]) { 
                root.removeChild(myElem);
                root.insertBefore(myElem, elems[pos+1]);
                myElem.style["top"] = "0px";
            }
            if (pos != 0 && y < offsets[pos - 1]) { 
                root.removeChild(myElem);
                root.insertBefore(myElem, elems[pos-1]);
                myElem.style["top"] = "0px";
            }
        };
        elems[i].onDragEnd = function(x,y,myElem) {
            myElem.style["top"] = "0px";
            
            ///////////
            
            rewrite(myElem);
            
            ///////////
        }
    }
    
  function recalcOffsets () {
		var elems = root.getElementsByTagName("li");
		for (var i = 0; i < elems.length; i++) {
			offsets[i] = elems[i].offsetTop;
		}
	}

	function whereAmI(elem) { 
		var elems = root.getElementsByTagName("li");
		for (var i = 0; i < elems.length; i++) {
			if (elems[i] == elem) { return i }
  	}
	}  	
    
  recalcOffsets();
}

function init_drag()
{
 for (var i=0; i<init_drag.arguments.length; ++i)
	redrag(document.getElementById(init_drag.arguments[i]));
}

