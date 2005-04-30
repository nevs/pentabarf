
var person_im_counter = 0;

function add_person_im(person_im_id, im_type_id, im_address)
{
  var table_row;
  var row_id = person_im_counter;
  person_im_counter++;
  
  document.getElementById('im_table').style.display = "block";
  table_row = document.createElement("tr");
  table_row.setAttribute("id","row_"+row_id);

  if (person_im_id) {
    element = new_element("a", 0,"person_im["+row_id+"][im_link]", im_scheme[im_type_id]+"://"+im_address);
    element.setAttribute("title", im_address);
    element.appendChild(new_element("img", 0, "person_im["+row_id+"][image]", "/images/icon-im-32x32.png"));
    table_data = document.createElement("td");
    table_data.appendChild(element);
    table_row.appendChild(table_data);
  } else {
    table_row.appendChild(create_element("img", 0, "person_im["+row_id+"][image]", "/images/icon-im-32x32.png"));
  }
  table_row.appendChild(create_element("input", "hidden", "person_im["+row_id+"][person_im_id]", person_im_id));
  table_row.appendChild(create_element("select", null, "person_im["+row_id+"][im_type_id]", im_type, im_type_id));
  table_row.appendChild(create_element("input", "text", "person_im["+row_id+"][im_address]", im_address, 25));
  table_row.appendChild(create_element("input", "checkbox", "person_im["+row_id+"][delete]"));
  
  document.getElementById("im_table_body").appendChild(table_row);

  if (init_done) enable_save_button();
  enumerator();

}
