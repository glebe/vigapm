$ ->
  $('.user-area').on 'ajax:success', '.mark-notification', (e) ->
    $(@).parent('.notification').remove()

    $.getJSON '/users_notifications', (data) ->
      $('#notifications-badge').html(data.total_count)
