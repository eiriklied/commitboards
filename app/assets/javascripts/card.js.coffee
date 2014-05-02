# open card
$(document).on 'click', 'ul.commits .image a', ->
  $('.js-card-overlay').removeClass('hidden')
  $.get $(this).attr('href'), (data) ->
    $('.js-card').html(data)
    $('.js-card #comment_body').focus()

# close card
$(document).on 'click', '.js-card-overlay', (e)->
  return unless $(this).is(e.target)
  $('.js-card-overlay').addClass('hidden')
  $('.js-card').html('') # clear card contents for later
