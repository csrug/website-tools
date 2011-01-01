require 'bundler'
Bundler.require(:default, :guides)

require 'config/config.rb'

module RubyonrailsCz
  class Application < Sinatra::Base

    enable :logging, :dump_errors, :raise_errors

    use Rack::Auth::Basic do |username, password|
      username == Config::USERNAME && password == Config::PASSWORD
    end

    post '/build' do
      cmd = []
      cmd << "cd #{Config::GUIDES}"
      cmd << "rm -rf output/cz"
      cmd << "git fetch origin"
      cmd << "git reset origin/czech --hard"
      cmd << "rake generate_guides ONLY=getting_started LANG=cz"
      puts "Running command: " + cmd.join(' && ')
      system cmd.join(' && ')
    end

  end
end

RubyonrailsCz::Application.run! if __FILE__ == $0
