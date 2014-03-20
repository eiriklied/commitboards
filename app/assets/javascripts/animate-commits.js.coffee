$ ->
  $commitsList = $('ul.commits')
  return unless $commitsList.length > 0

  $lastCommit = $commitsList.find('li:first')
  $lastCommit.addClass('animated fadeInDown')
