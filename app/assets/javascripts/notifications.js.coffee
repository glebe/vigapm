$ ->
  $('.user-area').on 'ajax:success', '.mark-notification', (e) ->
    $(@).parent('.notification').remove()

    $.getJSON '/users_notifications', (data) ->
      $('#notifications-badge').html(data.total_count)

  $('.user-area').on 'click', 'div[data-notification-post-id]', (e) ->
    post_path = Routes.post_path($(@).data('notification-post-id'))
    window.location.href = post_path
