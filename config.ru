# adjust port to 9292
#\ -p 9292

require 'rubygems'
require 'bundler'

Bundler.require

require 'rack'
require 'rack/contrib'

# assets
require 'sprockets'

use Rack::Deflater

map '/assets' do
  environment = Sprockets::Environment.new
  environment.append_path 'assets'
  #environment.engines['.slim'] = Slim::Template

  run environment
end

# deliver static content from the public folder
use Rack::Static, :root => 'public', :index => 'index.html'

# mount the phonebook api
$LOAD_PATH << '.'
require 'lib/phonebook'

run Sinatra::Application

