# open card
# $(document).on 'click', '.image', ->
#   $('.js-card-overlay').removeClass('hidden')
#   $.get $this.data('card'), (html) ->


# close card
$(document).on 'click', '.js-card-overlay', (e)->
  return unless $(this).is(e.target)
  $('.js-card-overlay').addClass('hidden')
  $('.js-card').html('') # clear card contents for later
