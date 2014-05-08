require 'bundler/setup'
require 'simplecov'
require 'rspec'
require 'ffaker'
require 'disposable_db'

include DisposableDB

SimpleCov.start do
  add_filter 'spec'
end

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  # Use color in STDOUT
  config.color_enabled = true

  # Use color not only in STDOUT but also in pagers and files
  config.tty = true

  config.before(:suite) do
  end

  config.after(:suite) do
  end
end
