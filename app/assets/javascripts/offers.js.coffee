# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# no need including the whole bootstrap js library just for this
$ ->
  $('div.alert button').click (e) ->
    e.preventDefault()
    $(this).parent().slideUp 'fast'
