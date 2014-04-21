$(window).load ->
  $message = $('#js-global-message')
  return unless $message.length > 0

  setTimeout (-> $message.addClass 'animated bounceOutUp animate-medium'), 3000

  $message.one 'webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', ->
    $message.addClass 'hidden'
