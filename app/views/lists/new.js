<script type="text/javascript" charset="utf-8">
  $(function () {
    // $("#lists")
    debugger
    var source = $("#lists-template").html();
    var template = Handlebars.compile(source);



    $.get("/lists.json", function(data) {


      var lists = data
      if (lists.length > 0) {
        debugger
        $("#lists").text(template(lists))
      }
    })
  })
</script>
