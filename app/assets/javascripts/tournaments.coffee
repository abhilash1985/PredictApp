# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ready page:load', ->
  $('[rel=\'tooltip\']').tooltip()
  $('.thumbnail').hover (->
    $(this).find('.caption').slideDown 250
    #.fadeIn(250)
    return
  ), ->
    $(this).find('.caption').slideUp 250
    #.fadeOut(205)
    return
  $('.modal_link').click (e) ->
    e.preventDefault()
    $('#modal_' + @id).modal()
    return
  $('.close_modal').click ->
    $('.close_modal').dialog 'close'
    return    
  return