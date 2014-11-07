
class CommentForm

  constructor: (@el, @url) ->
    @body = @el.find('.comment-body p')
    @body.prop('contenteditable', true)
    @body.focus()
    @initHandler()

  initHandler: ->
    $(document).on 'keyup', '.comment-body', (e) =>
      @submit() if e.which == 13

  submit: ->
    # remove whitespace and newlines
    @body.text(@body.text().trim().replace(/(\r\n|\n|\r)/gm,""))
    data =
      comment:
        body: @body.text()
    
    Q($.ajax
        url: @url
        method: 'patch'
        data: data
        dataType: 'json'
    ).then( (result) =>
      @body.prop('contenteditable', false)
      @el.addClass('updated')
      callback = => @el.removeClass('updated')
      setTimeout callback, 1000
    )
    .fail( (jqXHR, status, error) =>
      # We'll handle this later
    ).done()

$(document).on 'click', '.edit-comment', (e) ->
  e.preventDefault()
  new CommentForm($(@).parents('.comment:first'), $(@).attr('href'))
  
