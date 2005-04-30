function watch(object, object_id) {

  var req = new phpRequest(p_base + "watch/" + object + "/" + object_id);
  req.method = "post";
  var response = req.execute();

  var msg = document.createTextNode(response);
  document.getElementById("watch-button-" + object + "-" + object_id).replaceChild(msg, document.getElementById("watch-button-" + object + "-" + object_id).firstChild);
}
