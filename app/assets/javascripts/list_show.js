$(document).ready(function() {
  attachListeners();
})


// function findId(group) {
//   debugger
//   return function(group) {
//     return group.id === group
//   }
// }

function findId(id, group) {
  for (var i=0; i < group.length; i++) {
    if (group[i].id == id) {
      return group[i];
    }
  }
}

function attachListeners() {
  // add a json view to the show pages so when trying to update each item for buying, the data is accessable.
  var values = {grocery_item: {
    bought: false
  }}

  $(".statusChange").on("click", function(e) {
    e.preventDefault()

    var id = this.attributes["data-item"].value

    var listJson = $.get(window.location.pathname+'.json')

    listJson.done(function(data) {
      var object = findId(id, data.grocery_items)
      debugger
    })


    var id = this.attributes["data-item"].value
    // var itemSave = $.ajax({
    //   type: "PATCH",
    //   url: `/grocery_items/${id}`,
    //   data: values
    // });
    // itemSave.done(function(data) {
    //   console.log("Hello")
    // })
  })
}



// function buyGrocery() {
//   // hijack the buy link with an event listener then have it change the value
//   debugger
//   var gameSave = $.post('/grocery_items/:id', values)
//   gameSave.done(function(data) {
//     debugger
//   })
//   // either go to the get route that will change the buy to unbuy, or adjust the actual database to present the opposite of what it currently is right now.
// }
