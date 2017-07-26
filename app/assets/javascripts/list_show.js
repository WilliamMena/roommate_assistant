$(document).ready(function() {
  attachListeners();
})

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
  if (item.bought) {
    div.getElementsByTagName('div')[0].className = 'finished-item'
    div.getElementsByClassName('statusChange')[0].textContent = "UnBuy"
  } else {
    div.getElementsByTagName('div')[0].className = 'unfinished-item'
    div.getElementsByClassName('statusChange')[0].textContent = "Buy"
  }
}


function attachListeners() {
  // add a json view to the show pages so when trying to update each item for buying, the data is accessable.
  var values = {grocery_item: {
    bought: false
  }}

  $(".statusChange").on("click", function(e) {
    e.preventDefault()
    // var authToken = $("input[name='authenticity_token']")[0].value

    var id = this.attributes["data-item"].value
    var listJson = $.get(window.location.pathname+'.json')

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
      boughtDiv(item, div)

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

  $('#new_grocery_item').on("submit", function(e) {
    e.preventDefault()
    url = this.action

    data = {
      'authenticity_token': $("input[name='authenticity_token']")[0].value,
      grocery_item: {
        'item': $('#item')[0].value,
        'bought': 'false'
      },
      'list_id': $('#list_id')[0].value
    }
    console.log(data)
    // $.post(url, data)

    $.ajax({
      type: "POST",
      url: url,
      data: data,
      success: function(success_data) {
        // have to check if I can tell if the current user is the owner of the list at this point
        data.grocery_item.id = success_data.grocery_id
        var source   = $("#list-item-template").html();
        var template = Handlebars.compile(source);
        debugger
        $('#list_items')[0].innerHTML += template(data.grocery_item)
        $(".statusChange").off('click')
        attachListeners();
      }
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
