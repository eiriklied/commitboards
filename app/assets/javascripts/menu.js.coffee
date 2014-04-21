$(document).on 'click', '.js-install-link', ->
  $installationInstructions = $('#installation-instructions').toggleClass('hidden animated bounceInDown animate-fast');
  if $installationInstructions.is(':visible')
    $('input[data-select-text]').select()
  return false


$(window).load ->
  $('input[data-select-text]').select()

$(document).on 'click', 'input[data-select-text]', ->
  $(this).select()
