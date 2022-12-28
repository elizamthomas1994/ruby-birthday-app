require 'sinatra/base'
require 'sinatra/reloader'
require 'date'

class Application < Sinatra::Base
  enable :sessions

  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    return erb(:index)
  end

  post '/submit' do
    session[:name] = params[:name]
    session[:birth_date] = params[:birth_date]
    session[:birth_month] = params[:birth_month]
    redirect '/birthday_check'
  end

  get '/birthday_check' do
    @name = session[:name]
    @birth_date = session[:birth_date]
    @birth_month = session[:birth_month]

    @day = @birth_date.to_i
    @month = @birth_month.to_i

    current_date = DateTime.now
    given_date = DateTime.new(2022, @month, @day)

    if current_date > given_date
      given_date = DateTime.new(2023, @month, @day)
    end

    @days_to_go = (current_date..given_date).count
    erb(:birthday_check)
  end
end