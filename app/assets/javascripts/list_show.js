$(document).ready(function() {
  attachListeners();
})

function attachListeners() {
  // add a json view to the show pages so when trying to update each item for buying, the data is accessable. 
  var values = {grocery_item: {
    bought: false
  }}
  $("#statusChange_1").on("click", function(e) {
    e.preventDefault()
    console.log("Hello")

    var itemSave = $.ajax({
      type: "PATCH",
      url: '/grocery_items/1',
      data: values
    });
    itemSave.done(function(data) {
      console.log("Hello")
    })
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
