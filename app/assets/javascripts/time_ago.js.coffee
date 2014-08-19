$ ->
  format_duration = (minutes, hours, days) ->
    if days > 6
      "#{days} days"
    else if days > 0
      "#{days} days #{hours} hours"
    else if hours > 0
      "#{hours} hours #{minutes} minutes"
    else
      "#{minutes} minutes"

  update_time_ago = ->
    time_now = moment()
    $('.time_ago').each ->
      time_ago    = time_now.diff($(this).data('time'), 'seconds_ago')
      minutes_ago = time_now.diff($(this).data('time'), 'minutes') % 60
      hours_ago   = time_now.diff($(this).data('time'), 'hours') % 24
      days_ago    = time_now.diff($(this).data('time'), 'days')

      $(this).text(format_duration minutes_ago, hours_ago, days_ago)

  update_time_ago()
  setInterval(update_time_ago, 60 * 1000)
