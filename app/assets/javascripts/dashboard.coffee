# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ready page:load', ->
  $('.dropdown').hover (->
    $('.dropdown-menu', this).stop(true, true).slideDown 'fast'
    $(this).toggleClass 'open'
    return
  ), ->
    $('.dropdown-menu', this).stop(true, true).slideUp 'fast'
    $(this).toggleClass 'open'
    return
  return