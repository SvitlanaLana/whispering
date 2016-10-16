require './boot.rb'
require 'sinatra/activerecord/rake'

namespace :heroku do
  task deploy: %i(push migrate)

  task :push do
    sh 'git push heroku master'
  end

  task :migrate do
    sh 'heroku run rake db:migrate'
  end

  task :console do
    sh 'heroku run rails console'
  end
end
