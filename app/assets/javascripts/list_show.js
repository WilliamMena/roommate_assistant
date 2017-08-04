function List(list) {
  this.id = list.id;
  this.title = list.title;
  this.user_id = list.user_id;
  this.list_type = list.list_type;
  this.viewers = list.viewers;
  this.user = list.user;
  this.grocery_items = list.grocery_items;
  this.chores = list.chores;
}

List.prototype.renderGroceryItem = function(){
  return List.groceryListTemplate(this)
}

List.prototype.renderChoreItem = function(){
  return List.choreListTemplate(this)
}


$().ready(function() {
  attachListeners();
  // List.partialSource = $('#grocery-item-template').html();
  // Handlebars.registerPartial('listItem', List.partialSource)
  List.groceryListSource   = $("#grocery-list-template").html();
  List.groceryListTemplate = Handlebars.compile(List.groceryListSource);
  List.choreListSource   = $("#chore-list-template").html();
  List.choreListTemplate = Handlebars.compile(List.choreListSource);
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


function nextLink(id, array) {
  for (i = 0; i < array.length; i++) {
    if (array[i].id == id) {
      var next = i+1
    }
  }
  if (array[next]) {
    return array[next]
  } else {
    return false
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
    // $.post(url, data)

    $.ajax({
      type: "POST",
      url: url,
      data: data,
      success: function(success_data) {
        // have to check if I can tell if the current user is the owner of the list at this point
        data.grocery_item.id = success_data.grocery_id
        var source   = $("#new-grocery-item-template").html();
        var template = Handlebars.compile(source);
        $('#list_items')[0].innerHTML += template(data.grocery_item)
        $(".statusChange").off('click')
        attachListeners();
      }
    })

  })


  $('#next_list').on('click', function(e) {
    // var currentButton = this

    // have to figure out how to have id available inside of the allLists scope
    var allLists = $.get('/lists.json')

    allLists.done(function(data) {
      var id = $('#next_list').attr('data-item')
      var listData = nextLink(id, data)
      let list = new List(listData)
      // Object.setPrototypeOf(list, List)
      if (list.list_type == "shopping") {
        var partialSource = $('#grocery-item-template').html();
        Handlebars.registerPartial('listItem', partialSource)
        // var source   = $("#grocery-list-template").html();
        // var template = Handlebars.compile(source);
        // $('#list').replaceWith(template(list))
        $('#list').replaceWith(list.renderGroceryItem())
        $("#next_list").off('click')
        attachListeners();

      } else if (list.list_type == "chore") {
        var partialSource = $('#chore-item-template').html();
        Handlebars.registerPartial('listItem', partialSource)
        // var source   = $("#chore-list-template").html();
        // var template = Handlebars.compile(source);

        $('#list').replaceWith(list.renderChoreItem())
        $("#next_list").off('click')
        attachListeners();
      } else {
        $('#next_list').replaceWith("This is your last viewable list.")
      }
    })


    // have to find out how to check users lists, and call the next one in the array
  })
}
