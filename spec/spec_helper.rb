# frozen_string_literal: true

require "rspec"
require_relative "../lib/lineageblock/lineage_block"
require_relative "../lib/lineageblock/lineage_bank"
require_relative "../lib/lineageblock/lineage_ledger"
require_relative "../lib/lineageblock/lineage_stock"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  # config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
