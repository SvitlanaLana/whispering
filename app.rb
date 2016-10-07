require 'sinatra/base'

class App < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  get '/' do
    erb :index
  end

  get '/hello/:name' do
    "Hello #{params[:name]}"

  end

  post '/messages' do
    params.inspect
    @message = Message.create(message_params(params))
    message_params(params).inspect
  end

  def message_params(params)
    binding.pry
    params['message'].slice('text')
  end
end
