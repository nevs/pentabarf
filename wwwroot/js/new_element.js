/**
 * create element for dynamic interface 
 *
 * @param type type of the element
 * @param subtype subtype of the element (only needed for type input)
 * @param name name of the element
 * @param values array of values or value
 * @param selected id of the selected element
*/

function new_element(type, subtype, name, values, selected)
{
  var new_element = document.createElement(type);
  new_element.setAttribute("name", name);
  new_element.setAttribute("tabindex", 0);

  switch (type) {
    case "a":
      new_element.setAttribute("href", values);
      break;
    case "button":
      new_element.setAttribute("type", "button");
      new_element.setAttribute("value", values);
      new_element.setAttribute("onClick", selected);
      new_element.appendChild(document.createTextNode(values));
      break;
    case "img":
      new_element.setAttribute("src", values);
      new_element.setAttribute("height", 32);
      new_element.setAttribute("width", 32);
      break;
    case "input":
      new_element.setAttribute("type", subtype);
      if (values) new_element.setAttribute("value", values);
      switch (subtype) {
        case "text":
          break;
        case "checkbox":
          if (selected) new_element.setAttribute("checked", "checked");
          break;
      }

      break;
    case "select":
      for (key in values) {
        var current = document.createElement("option");
        current.setAttribute("value",key);
        if (key == selected) {
          current.setAttribute("selected","selected");
        }
        current.appendChild(document.createTextNode(values[key]));
        new_element.appendChild(current);
      }
      break;
  
  }
  
  return new_element;
}


