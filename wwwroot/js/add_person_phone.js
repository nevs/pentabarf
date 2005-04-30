
var person_phone_counter = 0;

function add_person_phone(person_phone_id, phone_type_id, number)
{
  var table_row;

  var row_id = person_phone_counter;
  person_phone_counter++;

  document.getElementById('telephone_table').style.display = "block";
  table_row = document.createElement("tr");
  table_row.setAttribute("id","row_"+row_id);

  if (person_phone_id) {
    element = new_element("a", 0,"phone["+row_id+"][url]", phone_scheme[phone_type_id]+"://"+number);
    element.setAttribute("title", number);
    element.appendChild(new_element("img", 0, "phone["+row_id+"][image]", "/images/icon-phone-32x32.png"));
    table_data = document.createElement("td");
    table_data.appendChild(element);
    table_row.appendChild(table_data);
  } else {
    table_row.appendChild(create_element("img", 0, "phone["+row_id+"][image]", "/images/icon-phone-32x32.png"));
  }
  table_row.appendChild(create_element("input", "hidden", "person_phone_id["+row_id+"]", person_phone_id));
  table_row.appendChild(create_element("select", 0, "phone_type_id["+row_id+"]", phone_type, phone_type_id));
  table_row.appendChild(create_element("input", "text", "phone_number["+row_id+"]", number));
  table_row.appendChild(create_element("input", "checkbox", "delete_number["+row_id+"]","1"))
  
  document.getElementById("telephone_table_body").appendChild(table_row);

  if (init_done) enable_save_button();
  enumerator();

}
