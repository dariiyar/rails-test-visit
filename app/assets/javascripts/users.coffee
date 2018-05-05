# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.initializeOnEvent =
  if window.Turbolinks? and window.Turbolinks.supported
    'turbolinks:load'
  else
    'ready'

$(document).on window.initializeOnEvent, ->
  $('.dropdown-toggle').dropdown()

  alertObject = (class_name, message, header) ->
    obj = {}
    obj.class = class_name
    obj.message = message
    obj.header = header
    obj

  $('#filter')
    .on 'ajax:success', (evt) ->
      [data] = evt.detail
      $('tbody tr').remove()
      $(data.users).each ->
        $('tbody').append HandlebarsTemplates['user'](this)

  $('#upload_csv')
    .on 'submit', (evt) ->
      $('.alert').remove()
    .on 'ajax:success', (evt) ->
      [data, status, xhr] = evt.detail
      $(data.users).each ->
        $("##{this.id}").remove()
        $('tbody').append HandlebarsTemplates['user'](this)
      $('h3').after HandlebarsTemplates['alert'](alertObject('alert alert-success', "CSV data imported successfully!!!", 'Well Done!')) unless data.errors.length
      if data.errors.length
        $('h3').after HandlebarsTemplates['alert'](alertObject('alert alert-warning', "CSV format data is correct, but some user attribute values has wrong format", 'Warning!'))
        $(data.errors).each ->
          $('#upload_csv').before HandlebarsTemplates['alert'](alertObject('alert alert-danger', this, null))
    .on 'ajax:error', (evt) ->
      [errors] = event.detail
      $(errors.errors).each ->
        $('h3').after HandlebarsTemplates['alert'](alertObject('alert alert-danger', this, 'Error!'))