require 'sinatra/base'

class App < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  get '/' do
    'Hello world'
  end

  get '/hello/:name' do
    "Hello #{params[:name]}"
  end
end
