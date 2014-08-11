$ ->
  $('.rvalue-qty').on 'change', ->
    qty    = $(this).val()
    $target = $("##{$(this).data('target')}")
    min    = $target.attr('min')
    max    = $target.attr('max')

    if qty < min
      $(this).val min
      qty = min

    if qty > max
      $(this).val max
      qty = max

    rvalue = parseInt($target.data('rvalue'),10)
    $target.text(rvalue * qty)

    total_rvalue = $target.parents('table').find('.rvalue').get().reduce((p,c,i,a) ->
      p + (parseInt($(c).text(),10) || 0)
    ,0)

    rvalue_type = $target.parents('table').data('type')
    $("#total-#{rvalue_type}-rvalue").text(total_rvalue)
