$(window).on 'load', ->
  $liveBoard = $('.js-live-board')
  return unless $liveBoard.length > 0

  MessageBus.start()
  MessageBus.subscribe "/board/#{$liveBoard.data('key')}", (data) ->
    eval data
