$(window).load ->
  $message = $('#js-global-message')
  return unless $message.length > 0

  setTimeout (-> $message.addClass 'animated fadeOutUp'), 5000

  $message.one 'webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', ->
    $message.addClass 'hidden'
