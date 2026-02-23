# frozen_string_literal: true

require "rspec/should"
require "rspec/should/enable"

RSpec.configure do |config|
  config.example_status_persistence_file_path = ".rspec_status"
end
