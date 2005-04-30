var conference_person_counter = 0;

function add_conference_person(conference_person_id, person_id, conference_role_id, remark)
{
  var table_row, table_data, element;

  var row_id = conference_person_counter;
  conference_person_counter++;

  document.getElementById('person_table').style.display = "block";
  table_row = document.createElement("tr");
  table_row.setAttribute("id","row_"+row_id);

  table_row.appendChild(create_element("input", "hidden", "conference_person["+row_id+"][conference_person_id]", conference_person_id));
  
  if (person_id) {
    element = new_element("a", 0, "conference_person[" + row_id + "][link]", p_base + "person/" + person_id );
    element.setAttribute("title", "Go to \""+person_names[person_id]+"\"");
    element.appendChild(new_element("img", 0, "conference_person["+row_id+"][image]", p_base + "images/person/" + person_id));
    table_data = document.createElement("td");
    table_data.appendChild(element);
    table_row.appendChild(table_data);
  } else {
    table_row.appendChild(create_element("img", 0, "conference_person["+row_id+"][image]", "/images/icon-person-32x32.png"));
  }

  table_row.appendChild(create_element("select", 0, "conference_person["+row_id+"][person_id]", person_names, person_id));
  table_row.appendChild(create_element("select", 0, "conference_person["+row_id+"][conference_role_id]",conference_roles,conference_role_id));
  table_row.appendChild(create_element("input", "text", "conference_person["+row_id+"][remark]", remark));
  table_row.appendChild(create_element("input", "checkbox", "conference_person["+row_id+"][delete]"));
  document.getElementById("person_table_body").appendChild(table_row);

  if (init_done) enable_save_button();
  enumerator();

}
