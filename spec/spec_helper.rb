require 'coveralls'
require 'database_cleaner'
Coveralls.wear!('rails')


RSpec.configure do |config|

  config.expect_with :rspec do |expectations|

    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end


  config.mock_with :rspec do |mocks|

    mocks.verify_partial_doubles = true
  end

  config.before(:suite) do
     DatabaseCleaner.strategy = :transaction
     DatabaseCleaner.clean_with(:truncation)
  end
# The settings below are suggested to provide a good initial experience
# with RSpec, but feel free to customize to your heart's content.

  config.before :each do
    ActionMailer::Base.deliveries.clear
  end

  config.filter_run :focus
  config.run_all_when_everything_filtered = true

end
