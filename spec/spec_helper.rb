# Sample spec_helper file
#
# This is always called when you run every spec test. This only serves as an example of
# how your own spec_helper file might look, but will very likely have code that is
# not shown here and vice-versa.
#
# ---------------------------------------------------------------------------------------

# Just in case there's any question, we're running this in the "test" environment
ENV["RAILS_ENV"] ||= 'test'

# Just like a Rails application, we want to load the configuration
# file for our environment
require File.expand_path("../../config/environment", __FILE__)

# Require things we need from our peripheral gems, like rspec matches for testing the
# equivalence of xml.
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rspec'
require 'equivalent-xml/rspec_matchers'
require 'database_cleaner'

# This is optional, but a good idea if you want to organize any additional code
# that supports your testing into separate files and directories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Disable WebMock and enable as needed per test
WebMock.disable!

# Make Capybara wait a bit longer so sluggish AJAX requests can finish
# on Travis, otherwise your test will be reported as a failure because
# Capybara attempted to check the page content before it had finished loading.
Capybara.default_wait_time = 15

# Here's the proper configuration for RSpec itself
RSpec.configure do |config|

  # Database cleaner
  #
  # We're using DatabaseCleaner to manage test records in the database so
  # we don't want Rails to manage any of our transactions
  config.use_transactional_fixtures = false

  # Setup DatabaseCleaner prior to running our tests
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  # Have a clean slate for every test
  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end

    # Clean out Solr and Fedora
    #
    # These are optional and can impact performance because they slow down the 
    # test suite.  Nevertheless, it is helpful to have them in a clean state
    # before each test.
    ActiveFedora::Base.delete_all
    Blacklight.solr.delete_by_query("*:*")
    Blacklight.solr.commit

    # If you're testing email, you can clear out any leftovers
    ActionMailer::Base.deliveries.clear
  end

  # Randomize your tests because it will often expose hidden issues
  # that may not be apparent because we tend to thing procedurally
  config.order = :random

  # This setting assumes you're using ActiveRecord fixtures, which you probably
  # aren't, but you can use it for other fixtures as well such as xml datastream
  # files and binary audiovisual content 
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # Devise includes a TestHelpers module that you can use when you're testing controllers
  # that require authenticated users.  Here, we've included them only in our controller tests.
  config.include Devise::TestHelpers, type: :controller

  # Warden comes with a some test helpers what we'll use in our feature tests
  config.include Warden::Test::Helpers, type: :feature

  # Include custom methods for your feature tests. See spec/support/custom_helpers.rb
  config.include CustomHelpers, type: :feature
  # Define all your sample models here and they can be used in any test. See spec/support/sample_models.rb
  config.include SampleModels

  # With this option, RSpec will be able to guess what kind of test you're running by looking
  # at the location of the file.  For example, RSpec will assume a file under the views directory is going
  # to be a view test and will make available the "rendered" method.  Tests under the 
  # feature directory will cause RSpec to use Capybara and render the entire web page.
  # If the file is under the controllers directory, you'll have routes available to you.
  config.infer_spec_type_from_file_location!

end
