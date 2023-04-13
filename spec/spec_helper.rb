ENV["RACK_ENV"] = "test"
RSpec.configure do |config|
  config.filter_gems_from_backtrace "rack", "rack-test", "sequel", "sinatra"

  config.when_first_matching_example_defined(:db) do
    require_relative "support/db"
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.filter_run_when_matching :focus

  config.example_status_persistence_file_path = "spec/examples.txt"

  config.disable_monkey_patching!

  #   config.warnings = true

  if config.files_to_run.one?
    config.default_formatter = "doc"
  end

  #   config.profile_examples = 10

  config.order = :random

  Kernel.srand config.seed
end
