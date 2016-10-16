require './boot.rb'
require 'sinatra/activerecord/rake'

namespace :heroku do
  task deploy: %i(push migrate)

  task :push, [:arg1] do |t, args|
    sh "git push heroku master #{args[:arg1]}"
  end

  task :migrate do
    sh 'heroku run bundle exec rake db:migrate'
  end

  task :console do
    sh 'heroku run bin/console'
  end
end
