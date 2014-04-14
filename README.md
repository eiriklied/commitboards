# Commitboards

> A place to show off how nerd you are

## Install locally

    # setup database
    [bundle exec] rake db:migrate
    # run the one test
    [bundle exec] rspec
    # start the server
    [bundle exec] rails s


## Todos

- write tests for install scripts (guessing full on integration tests is the only way to test this)
- write tests for posting new commits to a board
- Add summary for boards:
  - number of commits
  - top committers
  - top projects
- should have `text/plain` header on boards#install response
- add board key/url to post-commit start/end comments to be able to add more commit board urls to one project?

### Done

- names (and commit messages??) with æøå f*#%s up the script with shellescape problems. Maybe # encoding: utf-8 will solve the problem? Need a terminal with US-ASCII encoding
- known bug: sometimes a computer comes back from offline
  - it uploads many commits, where the oldest commits are uploaded last.
  - this causes the auto updating js to poll for last with an id
  - fixed by using id of last commit when polling, looking up the last commit and searching for commits with committed_at after that specific commit
- add automatic updating (check if response sais update. If so, run the install command with curl)
- get github url/add github link to commit
- add some more css animations with better installation instructions
- obey system proxy settings for people on vpn
- show entire command in install input box so people copy the whole thing (right now its a bit too narrow)
- declare ruby version in Gemfile
- force https on heroku
- add commit sha to commit
- resize images with imagemagic/imagesnap (imagemagick for now)
- add committer and project name to commit
- parse timestamp of commit and save as committed_at
- upload commit time as well
- try to upload previous unsuccessful uploads
- delete/clean successful uploads
- in background-capture: Show the actual board url, not the commits
