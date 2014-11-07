
class CommentForm

  constructor: (@el, @url) ->
    @body = @el.find('.comment-body')
    @body.prop('contenteditable', true)
    @initHandler()

  initHandler: ->
    $(document).on 'keyup', '.comment-body', (e) =>
      @submit() if e.which == 13

  submit: ->
    data =
      comment:
        body: @body.text
    
    Q($.ajax
        url: @url
        method: 'put',
        data: data
    ).then( (result) =>
      debugger
    )
    .fail( (jqXHR, status, error) =>
      debugger
    ).done()

@CommentForm = CommentForm

$(document).on 'click', '.edit-comment', (e) ->
  e.preventDefault()
  new CommentForm($(@).parents('.comment:first'), $(@).attr('href'))
  
