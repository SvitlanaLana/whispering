require 'sinatra/base'

class App < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  use Rack::Session::Pool, expire_after: 2
  set :session_secret, 'super secret'
  set :public_folder, 'public'

  get '/' do
    erb :index
  end

  post '/messages' do
    @message = Message.create(message_params(params))
    if @message.errors.empty?
      session['new_message_key'] = @message.key
      session['result'] = 'new_message'
    else
      session['result'] = 'message_creation_failure'
    end
    redirect('/')
  end

  get '/messages/:key' do
    @message = Message.fetch(params[:key])
    if @message
      erb :show
    else
      status 404
      erb :oops
    end
  end

  private

  def new_message_key
    session['new_message_key']
  end

  def message_creation_result
    session['result']
  end

  def message_params(params)
    hash = params['message'].slice('text', 'deadline')
    if params['message']['deadline_type'] == 'count'
      hash['left_shows'] = hash.delete('deadline')
    end
    hash
  end
end
