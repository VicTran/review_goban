jQuery ->
  $(document).on 'click', '.remove_row', (event) ->
    $(this).closest('tr').find('.check-remove').val('1')
    $(this).closest('tr').find('.price').val('1')
    $(this).closest('tr').hide()
    event.preventDefault()

