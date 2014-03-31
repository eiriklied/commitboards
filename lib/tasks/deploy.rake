require 'net/http'

namespace :deploy do

  desc "Git push, migrate db and restart app to heroku for production env"
  task :production do
   settings = {
      branch: 'master', # never deploy anything else to production
      git_remote: 'git@heroku.com:commitboards.git',
      app_name: 'commitboards',
      url: 'https://commitboards.herokuapp.com' }
   full_deploy settings
  end

  #desc "Git push, migrate db and restart app on heroku for production env"
  #task :production do
  #  settings = { git_remote: 'git@heroku.com:ships.git', app_name: 'ships' }
  #  full_deploy settings
  #end
end


def full_deploy env
  push_app env
  migrate_db env
  restart_app env
  wake_up_request env
end

def push_app env
  puts "Pushing git repo to heroku"

  system "git push #{env[:git_remote]} #{env[:branch]}:master"
end

def migrate_db env
  puts "Running rake db:migrate on heroku"
  system "bundle exec heroku run rake db:migrate --app #{env[:app_name]}"
end

def restart_app env
  puts "Restarting heroku app"
  system "bundle exec heroku restart --app #{env[:app_name]}"
end

def wake_up_request env
  puts "Making a small request just to wake up the heroku dynos"
  url = URI(env[:url])
  Net::HTTP.get(url)
end
