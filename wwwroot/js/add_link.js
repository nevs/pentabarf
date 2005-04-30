var link_counter = 0;

function add_public_link(link_id, link_type_id, url, title, description)
{
  var table_row, table_data, element;
  var row_id = link_counter;

  link_counter++;

  document.getElementById('public_link_table').style.display = "block";
  table_row = document.createElement("tr");
  table_row.setAttribute("id","row_"+row_id);

  if (link_id) {
    element = new_element("a", 0,"link["+row_id+"][url]", url);
    element.setAttribute("title", title);
    element.appendChild(new_element("img", 0, "link["+row_id+"][image]", "/images/icon-link-32x32.png"));
    table_data = document.createElement("td");
    table_data.appendChild(element);
    table_row.appendChild(table_data);
  } else {
    table_row.appendChild(create_element("img", 0, "link["+row_id+"][image]", "/images/icon-link-32x32.png"));
  }
  table_row.appendChild(create_element("input", "hidden", "link["+row_id+"][link_id]", link_id));
  table_row.appendChild(create_element("select", 0, "link["+row_id+"][link_type_id]", public_link_types, link_type_id));
  table_row.appendChild(create_element("input", "text", "link["+row_id+"][url]", url));
  table_row.appendChild(create_element("input", "text", "link["+row_id+"][title]", title));
  table_row.appendChild(create_element("input", "text", "link["+row_id+"][description]", description));
  table_row.appendChild(create_element("input", "checkbox", "link["+row_id+"][delete]"));
  document.getElementById("public_link_table_body").appendChild(table_row);

  if (init_done) enable_save_button();
  enumerator();

}

function add_internal_link(link_id, link_type_id, url, title, description)
{
  var table_row, table_data, element;

  var row_id = link_counter;
  link_counter++;

  document.getElementById('internal_link_table').style.display = "block";
  table_row = document.createElement("tr");
  table_row.setAttribute("id","row_"+row_id);

  if (link_id) {
    element = new_element("a", 0,"link["+row_id+"][url]", url);
    element.setAttribute("title", title);
    element.appendChild(new_element("img", 0, "link["+row_id+"][image]", "/images/icon-link-32x32.png"));
    table_data = document.createElement("td");
    table_data.appendChild(element);
    table_row.appendChild(table_data);
  } else {
    table_row.appendChild(create_element("img", 0, "link["+row_id+"][image]", "/images/icon-link-32x32.png"));
  }
  table_row.appendChild(create_element("input", "hidden", "link["+row_id+"][link_id]", link_id));
  table_row.appendChild(create_element("select", 0, "link["+row_id+"][link_type_id]", internal_link_types, link_type_id));
  table_row.appendChild(create_element("input", "text", "link["+row_id+"][url]", url));
  table_row.appendChild(create_element("input", "text", "link["+row_id+"][title]", title));
  table_row.appendChild(create_element("input", "text", "link["+row_id+"][description]", description));
  table_row.appendChild(create_element("input", "checkbox", "link["+row_id+"][delete]"));
  document.getElementById("internal_link_table_body").appendChild(table_row);

  if (init_done) enable_save_button();
  enumerator();

}

function add_link(link_id, link_type_id, url, title, description)
{
  var table_row;

  var row_id = link_counter;
  link_counter++;

  document.getElementById('link_table').style.display = "block";
  table_row = document.createElement("tr");
  table_row.setAttribute("id","row_"+row_id);

  if (link_id) {
    element = new_element("a", 0,"link["+row_id+"][url]", url);
    element.setAttribute("title", title);
    element.appendChild(new_element("img", 0, "link["+row_id+"][image]", "/images/icon-link-32x32.png"));
    table_data = document.createElement("td");
    table_data.appendChild(element);
    table_row.appendChild(table_data);
  } else {
    table_row.appendChild(create_element("img", 0, "link["+row_id+"][image]", "/images/icon-link-32x32.png"));
  }
  table_row.appendChild(create_element("input", "hidden", "link["+row_id+"][link_id]", link_id));
  table_row.appendChild(create_element("select", 0, "link["+row_id+"][link_type_id]", link_types, link_type_id));
  table_row.appendChild(create_element("input", "text", "link["+row_id+"][url]", url));
  table_row.appendChild(create_element("input", "text", "link["+row_id+"][title]", title));
  table_row.appendChild(create_element("input", "text", "link["+row_id+"][description]", description));
  table_row.appendChild(create_element("input", "checkbox", "link["+row_id+"][delete]"));
  document.getElementById("link_table_body").appendChild(table_row);

  if (init_done) enable_save_button();
  enumerator();

}
