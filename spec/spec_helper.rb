require 'chefspec'
require 'chefspec/berkshelf'
require 'chefspec/cacher'
require 'chefspec/server_runner'

RSpec.configure do |config|
  config.log_level = :warn
  config.raise_errors_for_deprecations!
end

ChefSpec::Coverage.start!
