$ ->
  $('.pp-qty').on 'change', ->
    qty = $(this).val()
    min = $(this).attr('min')
    max = $(this).attr('max')

    if qty < min
      $(this).val min
      qty = min

    if qty > max
      $(this).val max
      qty = max

    localStorage.setItem($(this).data('name'), qty)

    # Sum up the power of all siblings
    power = $(this).parents('tr').find('.pp-qty').get().reduce((p,c,i,a) ->
      q = $(c).val()
      power = $(c).data('power')
      p + q * power
    ,0)

    $('#pp-power').text(power)

    $(this).parents('tr').find('.pp-qty').each ->
      q = $(this).val()
      p = parseFloat($(this).data('power'),10)
      pct = (p * q / power * 100).toFixed(2)
      $(this).parents('tbody').find("##{$(this).data('name')}-pct").text("#{pct}%")


  $('.pp-qty').each ->
    key = $(this).data 'name'
    value = localStorage.getItem key
    $(this).val value
    $(this).trigger 'change'
