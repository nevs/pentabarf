
var conference_track_counter = 0;

function add_room(room_id, short_name, f_public, size, remark, rank)
{
  var table_row;
  var row_id = conference_track_counter;
  conference_track_counter++;

  document.getElementById('room_table').style.display = "block";
  table_row = document.createElement("tr");
  table_row.setAttribute("id", "row_" + row_id);

  table_row.appendChild(create_element("input", "hidden", "room[" + row_id + "][room_id]", room_id));
  table_row.appendChild(create_element("input", "text", "room[" + row_id + "][short_name]", short_name));
  table_row.appendChild(create_element("input", "text", "room[" + row_id + "][rank]", rank, 3));
  table_row.appendChild(create_element("input", "checkbox", "room[" + row_id + "][f_public]", 1, f_public));
  table_row.appendChild(create_element("input", "checkbox", "room[" + row_id + "][delete]"));

  document.getElementById("room_table_body").appendChild(table_row);

  if (init_done) enable_save_button();
  enumerator();

}
