function showLists() {
  var source   = $("#lists-template").html();
  var template = Handlebars.compile(source);
  $.get("/lists.json", function(data) {
    var lists = data
    if (lists.length > 0) {
      $("#lists")[0].innerHTML = template(lists)
    }
  })
}
