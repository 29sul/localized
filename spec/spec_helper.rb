require 'coveralls'
Coveralls.wear!

require 'pry'
require 'localized'

# Load files translations and set as default :en
path = File.dirname(__FILE__)
I18n.load_path += Dir[ File.join(path, 'locale', '*.{rb,yml}') ]
I18n.enforce_available_locales = false
I18n.default_locale = :en

Time.zone = 'UTC'

ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"
