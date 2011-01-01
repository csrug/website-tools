require 'bundler'
Bundler.require(:default, :guides)

require 'config/config.rb'

module RubyonrailsCz
  class Application < Sinatra::Base

    enable :logging, :dump_errors, :raise_errors

    use Rack::Auth::Basic do |username, password|
      username == Config::USERNAME && password == Config::PASSWORD
    end

  end
end

RubyonrailsCz::Application.run! if __FILE__ == $0
