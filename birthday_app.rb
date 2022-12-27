require 'sinatra/base'
require 'sinatra/reloader'

class Application < Sinatra::Base
  # This allows the app code to refresh
  # without having to restart the server.
  configure :development do
    register Sinatra::Reloader
  end

  # Declares a route that responds to a request with:
  #  - a GET method
  #  - the path /
  get '/' do
    return erb(:index)
  end
end