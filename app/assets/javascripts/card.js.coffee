$(document).on 'card:initialize', '.js-card', ->
  $('.js-card #comment_body').focus()

# open card
$(document).on 'click', '*[data-open-card]', ->
  $('.js-card-overlay').removeClass('hidden')
  $.get $(this).attr('href'), (data) ->
    $('.js-card').html(data)
    $('.js-card').trigger('card:initialize');
  return false

# close card
$(document).on 'click', '.js-card-overlay', (e)->
  return unless $(this).is(e.target)
  $('.js-card-overlay').addClass('hidden')
  $('.js-card').html('') # clear card contents for later
