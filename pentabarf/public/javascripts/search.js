
var search_counter = 0;
var elements = 0;


var attribute = new Array();
attribute['text'] = new Array();
attribute['text'][0] = 'contains';
attribute['text'][1] = 'does not contain';
attribute['keyword'] = new Array();
attribute['keyword'][0] = 'is';
attribute['keyword'][1] = 'is not';


function construct_element(tag, css_class, id, name)
{
  var element;
  element = document.createElement(tag);
  if (css_class) element.setAttribute("class", css_class);
  if (id) element.setAttribute("id", id);
  if (name) element.setAttribute("name", name)
  return element;
}

/**
*
* Adds a new search criteria to the node 'id'.
*
* @param id DOM id of the node of elements
*
*/
function search_criteria_add(id, elem_me, value1, value2, value3)
{
  var d = document;
  var search = d.getElementById(id);
  search_counter++;
  elements++;

  if(search)
  {
    var row = construct_element("div", "search_row", "div_search_" + search_counter);
    var field1 = construct_element("span", "search_element", "span_search_field1_" + search_counter);
    var container = construct_element("span", "search_container", "span_search_container" + search_counter);
    var field_add = construct_element("span", "search_element", "span_search_fieldadd_" + search_counter);
    var field_remove = construct_element("span", "search_element", "span_search_fieldremove_"+search_counter);

    /* Criteria */
    var dropdown_criteria = construct_element("select", 0, "select_search_field1_criteria"+search_counter, "search["+search_counter+"][type]");
    dropdown_criteria.setAttribute("size", "1");
    dropdown_criteria.setAttribute("onchange", "javascript:search_criteria_changed(\""+row.getAttribute("id")+"\", "+search_counter+");");

    for (var i=0; i<criteria.length; i++)
    {
      var criteria_text = d.createTextNode(criteria[i]["name"]);
      var criteria_option = d.createElement("option");
      criteria_option.setAttribute("value", criteria[i]["value"]);
      if (value1 == criteria[i]["value"]) criteria_option.setAttribute("selected", "selected");
      criteria_option.appendChild(criteria_text);
      dropdown_criteria.appendChild(criteria_option);
    }

    /* Add */
    var plus = d.createElement("a");
    plus.setAttribute("href", "javascript:search_criteria_add(\""+id+"\", \""+row.getAttribute("id")+"\");");
    plus.setAttribute("class", "search");
    var plus_img = document.createElement("img");
    plus_img.setAttribute("src", p_base + "images/icon-plus-16x16.png");
    plus.appendChild(plus_img);

    /* Remove */
    var minus = d.createElement("a");
    minus.setAttribute("href", "javascript:search_criteria_remove(\""+id+"\", \""+row.getAttribute("id")+"\");");
    minus.setAttribute("class", "search");
    var minus_img = document.createElement("img");
    minus_img.setAttribute("src", p_base + "images/icon-minus-16x16.png");
    minus.appendChild(minus_img);

    field1.appendChild(dropdown_criteria);
    field_add.appendChild(plus);
    field_remove.appendChild(minus);

    row.appendChild(field_add);
    row.appendChild(field_remove);
    row.appendChild(field1);
    row.appendChild(container);

    // ADD
    var node = search.firstChild;
    while (node!=null) {
      if(node.nodeType == 1) {
        if(node.getAttribute("id") == elem_me) {
          node_next  = node.nextSibling;
          if(node_next == null) {
            elem_me = 0;
          } else
            search.insertBefore(row, node_next);
        }
      }
      node = node.nextSibling;
    }

    if(elem_me == 0)
      search.appendChild(row);

    /* Virtual Call for initalizing*/
    search_criteria_changed(row.getAttribute("id"), search_counter, value2, value3);

  }
}

/**
*
* Removes the given search criteria (row) in the search node (layer)
*
* @param id_search DOM id of the node where the row is located
* @param id_row DOM id of the row to remove
*/
function search_criteria_remove(id_search, id_row)
{
  /* get elements in DOM tree */
  var d = document;
  var search = d.getElementById(id_search);
  var row = d.getElementById(id_row);

  /* search existing? remove everything? */
  if (search && elements > 1) {
    search.removeChild(row);
    elements -= 1;
  }
}


/**
*
* Called if first dropdown changed
*
* @param id_row DOM id of the row to remove
*/

function search_criteria_changed(id_row, counter, value2, value3)
{
  var d = document;
  var row = d.getElementById(id_row);
  var dropdown = d.getElementById("select_search_field1_criteria"+counter);
  var container =  d.getElementById("span_search_container"+counter);

  if (row && dropdown && container) {
    /*  New container */
    var container_new = construct_element("span", "search_container", "span_search_container"+counter);

    /* Misc */
    if(criteria[dropdown.selectedIndex]["type"] == "text") {
      var field1 = construct_element("span", "search_element", "span_search_container_dropdown1_"+counter);
      var container_second = construct_element("span", "search_container_second", "span_search_container_second"+counter);

      /* Dropdown */
      var dropdown = d.createElement("select");
      dropdown.setAttribute("size", "1");
      dropdown.setAttribute("id", "select_search_dropdown"+counter);
      dropdown.setAttribute("name", "search["+counter+"][logic]");
      dropdown.setAttribute("onchange", "javascript:search_criteria2_changed(\""+row.getAttribute("id")+"\", "+ counter+");");

      for (var i=0; i<attribute["text"].length; i++) {
        var option_text = d.createTextNode(attribute["text"][i]);
        var option = d.createElement("option");
        option.setAttribute("id", "option_search_dropdown"+counter);
        option.setAttribute("name", "option_search_dropdown"+counter);
        if (value2 == attribute["text"][i]) option.setAttribute("selected", "selected");
        option.setAttribute("value", attribute["text"][i]);
        option.appendChild(option_text);
        dropdown.appendChild(option);
      }
    } else if(criteria[dropdown.selectedIndex]["type"] == "keyword") {
      var field1 = d.createElement("span");
      field1.setAttribute("id", "span_search_container_dropdown1_"+counter);
      field1.setAttribute("class", "search_element");

      var container_second = d.createElement("span");
      container_second.setAttribute("id", "span_search_container_second"+counter);
      container_second.setAttribute("class", "search_container_second");

      /* Dropdown */
      var dropdown = d.createElement("select");
      dropdown.setAttribute("size", "1");
      dropdown.setAttribute("id", "select_search_dropdown"+counter);
      dropdown.setAttribute("name", "search["+counter+"][logic]");
      dropdown.setAttribute("onchange", "javascript:search_criteria2_changed(\""+row.getAttribute("id")+"\","+counter+");");

      for (var i in attribute["keyword"]) {
        if ( i in Object.prototype || i in Array.prototype ) {
          continue;
        }
        var option_text = d.createTextNode(attribute["keyword"][i]);
        var option = d.createElement("option");
        option.setAttribute("value", attribute["keyword"][i]);
        if (value2 == attribute["keyword"][i]) option.setAttribute("selected", "selected");
        option.appendChild(option_text);
        dropdown.appendChild(option);
      }
    }

    if(field1 && container_second) {
      field1.appendChild(dropdown);
      container_new.appendChild(field1);
      container_new.appendChild(container_second);
    }

    if(container_new && container && row)
        /* replace old Container with new one */
      row.replaceChild(container_new, container);

    /* Virtual Call again */
    search_criteria2_changed(row.getAttribute("id"), counter, value3);
  }
}

/**
*
* Called if second dropdown changed
*
* @param id_row DOM id of the row to remove
* @param count integer created on adding
*/
function search_criteria2_changed(id_row, counter, value3)
{
  var d = document;
  var row = d.getElementById(id_row);
  var dropdown_first = d.getElementById("select_search_field1_criteria"+counter);
  var dropdown = d.getElementById("select_search_dropdown"+counter);
  var container = d.getElementById("span_search_container"+counter);
  var container_second = d.getElementById("span_search_container_second"+counter);

  if (row && dropdown && container_second)
  {
    /* New second container */
    var container_new = d.createElement("span");
    container_new.setAttribute("id", "span_search_container_second"+counter);
    container_new.setAttribute("class", "search_container_second");

    var x = criteria[dropdown_first.selectedIndex]["type"];

    /* Text */
    if(x == "text")
    {
      /* Textbox */
      var input = d.createElement("input");
      input.setAttribute("type", "text");
      input.setAttribute("id", "input_search"+counter);
      input.setAttribute("name", "search["+counter+"][value]");
      if (value3) input.setAttribute("value", value3);

      container_new.appendChild(input);
    } else if(x == "keyword") {
     /* Dropdown */
      var dropdown = d.createElement("select");
      dropdown.setAttribute("size", "1");
      dropdown.setAttribute("id", "select_search_dropdown2_"+counter);
      dropdown.setAttribute("name", "search["+counter+"][value]");

      for (var i in valuelists[dropdown_first.selectedIndex]) {
        if ( i in Object.prototype || i in Array.prototype ) {
          continue;
        }
        var option_text = d.createTextNode(valuelists[dropdown_first.selectedIndex][i]);
        var option = d.createElement("option");
        option.setAttribute("value", i);
        if (value3 == i) option.setAttribute("selected", "selected");
        option.appendChild(option_text);
        dropdown.appendChild(option);
      }

      container_new.appendChild(dropdown);
    }
    container.replaceChild(container_new, container_second);
  }
}

