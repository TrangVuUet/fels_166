$(document).on "ready page:load", ->
  $("#login_button").on "click", (event) ->
    $("#login_one").slideToggle(1000);
    event.stopPropagation();
