
var conference_track_counter = 0;

function add_conference_track(conference_track_id, tag)
{
  var table_row;
  var row_id = conference_track_counter;
  conference_track_counter++;

  document.getElementById('conference_track_table').style.display = "block";
  table_row = document.createElement("tr");
  table_row.setAttribute("id", "row_" + row_id);

  table_row.appendChild(create_element("input", "hidden", "conference_track_id[" + row_id + "]", conference_track_id));
  table_row.appendChild(create_element("input", "text", "conference_track_tag[" + row_id + "]", tag));
  table_row.appendChild(create_element("input", "checkbox", "delete_conference_track[" + row_id + "]"));

  document.getElementById("conference_track_table_body").appendChild(table_row);

  if (init_done) enable_save_button();
  enumerator();

}

var team_counter = 0;

function add_team(team_id, tag)
{
  var table_row;
  var row_id = team_counter;
  team_counter++;

  document.getElementById('team_table').style.display = "block";
  table_row = document.createElement("tr");
  table_row.setAttribute("id", "row_" + row_id);

  table_row.appendChild(create_element("input", "hidden", "team[" + row_id + "][team_id]", team_id));
  table_row.appendChild(create_element("input", "text", "team[" + row_id + "][tag]", tag));
  table_row.appendChild(create_element("input", "checkbox", "team[" + row_id + "][delete]"));

  document.getElementById("team_table_body").appendChild(table_row);

  if (init_done) enable_save_button();
  enumerator();

}
