# frozen_string_literal: true
require 'capybara/poltergeist'

module SessionSupport
  # The default login
  def sign_in(user = nil)
    driver = driver_name(user)
    Capybara.register_driver(driver) do |app|
      Capybara::RackTest::Driver.new(app,
                                     respect_data_method: true,
                                     headers: request_headers(user))
    end
    Capybara.current_driver = driver
  end

  # Login with a  default Poltergeist-enabled session
  def sign_in_with_js(user = nil, opts = {})
    sign_in_with_named_js(:poltergeist, user, opts)
  end

  # Login with a differently-names Poltergeist session. This is useful if you need to
  # create two different sessions within the same test.
  def sign_in_with_named_js(name, user = nil, opts = {})
    Capybara.register_driver name do |app|
      Capybara::Poltergeist::Driver.new(app, defaults.merge(opts))
    end
    Capybara.current_driver = name
    page.driver.headers = request_headers(user)
  end

  private

    def driver_name(user = nil)
      if user
        "rack_test_authenticated_header_#{user.email}"
      else
        "rack_test_authenticated_header_anonymous"
      end
    end

    # Pass any additional headers, if needed. For example if you're using
    # SSO authentication or other identity management services, you can add
    # these parameters here.
    def request_headers(_user = nil)
      {}
    end

    # Default settings for the Poltergeist driver
    def defaults
      {
        js_errors: true,
        timeout: 90,
        phantomjs_options: ['--ssl-protocol=ANY']
      }
    end
end
