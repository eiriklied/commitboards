$(document).on 'card:initialize', '.js-card', ->
  $(document).find('.js-comment-body').atwho({
    at: ":",
    tpl: "<li data-value=':${name}:'><img src='https://a248.e.akamai.net/assets.github.com/images/icons/emoji/${name}.png' height='20' width='20'/> ${name} </li>",
    data: window.emojis
  }).focus()


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
