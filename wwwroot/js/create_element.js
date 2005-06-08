/**
 * create element for dynamic interface 
 *
 * @param type type of the element
 * @param subtype subtype of the element (only needed for type input)
 * @param name name of the element
 * @param values array of values or value
 * @param selected id of the selected element
*/

function create_element(type, subtype, name, values, selected)
{
  var new_element = document.createElement(type);
  
  if (name != null) {
    new_element.setAttribute("name", name);
    new_element.setAttribute("id", name);
  }

  switch (type) {
    case "a":
      new_element.setAttribute("href", values);
      break;
    case "button":
      new_element.setAttribute("tabindex", 0);
      new_element.setAttribute("type", "button");
      new_element.setAttribute("value", values);
      new_element.setAttribute("onClick", selected);
      new_element.appendChild(document.createTextNode(values));
      break;
    case "img":
      new_element.setAttribute("src", values);
      break;
    case "input":
      new_element.setAttribute("tabindex", 0);
      new_element.setAttribute("type", subtype);
      if (values) new_element.setAttribute("value", values);
      switch (subtype) {
        case "hidden":
          return new_element;
          break;
        case "text":
          if (selected) new_element.setAttribute("size", selected)
          break;
        case "checkbox":
          if (selected == 't') new_element.setAttribute("checked", "checked");
          break;
      }

      break;
    case "select":
      new_element.setAttribute("tabindex", 0);
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
  
  table_cell = document.createElement("td");
  table_cell.appendChild(new_element);

  return table_cell;
}
