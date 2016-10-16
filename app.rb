require 'sinatra/base'

class App < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  #use Rack::Session::Pool, expire_after: 1
  #set :session_secret, 'super secret'
  set :public_folder, 'public'

  get '/' do
    erb :index
  end

  post '/messages' do
    @message = Message.create(message_params(params))
    flash = {}
    if @message.errors.empty?
      flash['new_message_key'] = @message.key
    else
      flash['error'] = 'message_creation_failure'
    end
    #redirect('/')
    redirect("/#{form_get_query(flash)}")
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
    params['new_message_key']
  end

  def message_saved?
    new_message_key
  end

  def bad_message?
    !params['error'].nil?
  end

  def message_params(params)
    hash = params['message'].slice('text', 'deadline')
    if params['message']['deadline_type'] == 'count'
      hash['left_shows'] = hash.delete('deadline')
    end
    hash
  end

  def form_get_query(hash)
    str = hash.map { |k, v| "#{k}=#{v}" }.join('&')
    return '?' + str unless str.empty?
  end
end
