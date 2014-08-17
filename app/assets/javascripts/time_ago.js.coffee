$ ->
  format_duration = (minutes, hours, days) ->
    if days > 2
      "#{days} days"
    else if days > 1
      "#{days} days #{hours} hours"
    else if hours > 1
      "#{hours} hours #{minutes} minutes"
    else
      "#{minutes} minutes"

  update_time_ago = ->
    time_now = moment()
    $('.time_ago').each ->
      minutes_ago = time_now.diff($(this).data('time'), 'minutes') % 60
      hours_ago   = time_now.diff($(this).data('time'), 'hours') % 24
      days_ago    = time_now.diff($(this).data('time'), 'days')

      $(this).text(format_duration minutes_ago, hours_ago, days_ago)

  update_time_ago()
  setInterval(update_time_ago, 60 * 1000)
