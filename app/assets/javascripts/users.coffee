# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
window.initializeOnEvent =
  if window.Turbolinks? and window.Turbolinks.supported
    'turbolinks:load'
  else
    'ready'

$(document).on window.initializeOnEvent, ->
  $('#upload_csv')
    .on 'ajax:success', (evt) ->
      [data, status, xhr] = event.detail
      $(data.users).each ->
        $("##{this.id}").remove()
        $('tbody').append HandlebarsTemplates['user'](this)
