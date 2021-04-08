# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ready page:load', ->
  $('[rel=\'tooltip\']').tooltip()
  $('.modal_link').click (e) ->
    e.preventDefault()
    $('#modal_' + @id).modal()
    return
  $('.close_modal').click ->
    $('.close_modal').dialog 'close'
    return
  return