$ ->
  $('.mark-notification').on 'ajax:success', (e) ->
    $(@).parent('.notification').remove()

    $.getJSON '/users_notifications', (data) ->
      $('#notifications-badge').html(data.total_count)
