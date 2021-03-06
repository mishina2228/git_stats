require 'simplecov'
SimpleCov.start do
  add_filter 'spec/'
end
if ENV['CI']
  require 'codecov'
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
end

require 'git_stats'

require 'factory_bot'
FactoryBot.find_definitions

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.order = :random
end
