$ ->
  $(document).on 'hidden.bs.modal', e ->
    $(e.target).removeData 'bs.modal'
