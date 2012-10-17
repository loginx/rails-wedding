$(document).on 'click', '[data-href]', (e) ->
  window.location.href = $(e.currentTarget).data('href')

$(document).on 'click', '[data-role="submit"]', (e) ->
  $(e.currentTarget).parents('form').submit()
