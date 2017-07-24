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

function findDiv(id, group) {
  for (var i=0; i < group.length; i++) {
    if (group[i].id == id) {
      return document.getElementsByClassName("buy_options")[i];
    }
  }
}

function boughtDiv(item, div) {
  var source   = $("#bought-item-template").html();
  var template = Handlebars.compile(source);
  div.innerHTML = template(item)
}

function unboughtDiv(item, div) {
  var source   = $("#unbought-item-template").html();
  var template = Handlebars.compile(source);
  div.innerHTML = template(item)
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

    var calledDiv = this

    listJson.done(function(data) {
      var item = findId(id, data.grocery_items)
      item.bought = !item.bought
      if (item.bought == false) {
        var buyPhrase = 'unbuy'
      } else {
        var buyPhrase = 'buy'
      }

      var itemSave = $.post(`/grocery_items/${id}/${buyPhrase}`)

      var div = findDiv(id, data.grocery_items)
      // if statement, if bought, one div, else other
      item.bought ? boughtDiv(item, div) : unboughtDiv(item, div)

    })

    // var itemSave = $.ajax({
    //   type: 'POST',
    //   url: `/grocery_items/${id}/${buyPhrase}`
    // });
    // itemSave.done(function(data) {
    //   debugger
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
