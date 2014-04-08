$(window).load ->
  $board = $('#board')
  return unless $board.length > 0

  getLastCommitSha = ->
    $lastCommit = $board.find('ul.commits li:first')
    return 0 if $lastCommit.length == 0
    return $lastCommit.data('commit-sha')

  updateBoard = (data) ->
    $(data).find('img').load ->
      $board.find('ul.commits').prepend data
      $lastCommit = $board.find('ul.commits li:first').addClass('animated bounceInDown animate-fast')


  pollForChanges = ->
    $.get $board.data('incoming-url'), {commit_sha: getLastCommitSha()}, (data) ->
      updateBoard(data) if data.trim() != ''



  setInterval(pollForChanges, 5000)
