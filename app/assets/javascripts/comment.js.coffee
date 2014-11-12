$(document).on 'click', '.edit-comment', (e) ->
  e.preventDefault()
  $comment = $(@).parents('.comment:first')
  $comment.find('.comment-body').hide()
  $comment.find('form').show()

$(document).on 'click', '#js-cancel', (e) ->
  e.preventDefault()
  $comment = $(@).parents('.comment:first')
  $comment.find('.comment-body').show()
  $comment.find('form').hide()

$(document).on 'ajax:success', '.new_comment', (e, data, status, xhr) ->
  $comments = $('.js-card .comments')
  $commit = $('.card-header .h3').data('commit')
  
  $comments.append(data)
  $(@).find('textarea').val('')
  $('.js-card').trigger('card:initialize') if $('.comment').length == 1 
  $("li[data-commit-sha='#{$commit}']").find('.comments-count').text($('.comment').length)

$(document).on 'ajax:success', '.edit_comment', (e, data, status, xhr) ->
  $comment = $(@).parents('.comment:first')
  $comment.find('p').html $(data).find('p').html()
  $comment.find('.comment-body').show()
  $comment.find('form').hide()


