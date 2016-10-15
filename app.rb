require 'sinatra/base'

class App < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  use Rack::Session::Pool, expire_after: 60
  set :session_secret, 'super secret'
  set :public_folder, 'public'

  get '/' do
    #binding.pry
    erb :index
  end

  get '/hello/:name' do
    "Hello #{params[:name]}"

  end

  post '/messages' do
    @message = Message.create(message_params(params))
    if @message.errors.empty?
      session['new_message_key'] = @message.key
      session['result'] = 'new_message'
    else
      session['result'] = 'message_createion_failure'
    end
    redirect('/')
  end

  get '/messages/:key' do
    @message = Message.find(params[:key])
    erb :show
  end

  private

  def new_message_key
    session['new_message_key']
  end

  def message_creation_result
    session['result']
  end

  def message_params(params)
    params['message'].slice('text', 'deadline')
  end
end