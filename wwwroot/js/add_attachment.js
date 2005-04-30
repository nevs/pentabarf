var attachment_counter = 0;

function add_attachment()
{
  var table_row;

  var row_id = attachment_counter;
  attachment_counter++;

  document.getElementById('attachment_upload_table').style.display = "block";
  table_row = document.createElement("tr");
  table_row.setAttribute("id","row_"+row_id);

  table_row.appendChild(create_element("select", 0, "attachment_upload["+row_id+"][attachment_type_id]", attachment_types));
  table_row.appendChild(create_element("input", "checkbox", "attachment_upload["+row_id+"][f_public]"));
  table_row.appendChild(create_element("input", "text", "attachment_upload["+row_id+"][title]"));
  table_row.appendChild(create_element("input", "file", "attachment_file_"+row_id));
  document.getElementById("attachment_upload_table_body").appendChild(table_row);

  if (init_done) enable_save_button();
  enumerator();

}
