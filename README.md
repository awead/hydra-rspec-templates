# Hydra RSpec Templates

Collection of sample RSpec test templates focused around a Sufia 7 application.

## Using this repo

Download this repo to your workstation and use it as a starting-point for experimenting with different
testing techniques using Hydra.

    git clone https://github.com/awead/hydra-rspec-templates
    bundle install
    bundle exec fcrepo_wrapper --config config/fcrepo_wrapper_test.yml &
    bundle exec fcrepo_wrapper &
    bundle exec solr_wrapper --config config/solr_wrapper_test.yml &
    bundle exec solr_wrapper &
    bundle exec rspec

This will install the gems, start up Fedora and Solr instances in the background, and runs the tests. You will see pending messages and failures. Look at the README for the topics covered here which includes
linked files of code for you to use as a starting point for setting up your own applications.

## Topics

### Dependencies

#### fcrepo_wrapper and solr_wrapper

These gems download, configure, and manage running instances of Fedora and Solr. You'll need one each for test and development environments.

#### Capybara

When running your feature tests, the entire page will be rendered as if it's in a browser.  Capybara will
do this and will also test javascript if you provide a driver.

* capybara-screenshot lets you use [save_and_open_page](spec/features/home_page_spec.rb) at any point during a test to see the web page
* poltergeist is a JS driver for capybara

#### Peripheral Gems

* [factory_girl_rails](https://github.com/thoughtbot/factory_girl_rails) - a fixtures replacement with a straightforward definition syntax, support for multiple build strategies...
* [database_cleaner](https://github.com/DatabaseCleaner/database_cleaner) - Strategies for cleaning databases in Ruby. Can be used to ensure a clean state for testing.
* [devise](https://github.com/plataformatec/devise) - Flexible authentication solution for Rails with Warden.
* [byebug (Ruby 2.0 only)](https://github.com/deivid-rodriguez/byebug) -
* [pry](https://github.com/pry/pry) - An IRB alternative and runtime developer console
* [better_errors](https://github.com/charliesome/better_errors) with [binding_of_caller](https://github.com/banister/binding_of_caller) - Retrieve the binding of a method's caller in MRI 1.9.2+
* [webmock](https://github.com/bblimke/webmock) - Library for stubbing and setting expectations on HTTP requests in Ruby.

#### Travis

* testing one or more Rubies
* sending out messages
* using a matrix to speed up the test suite
* installing dependencies
* automated configuration and startup of hydra-jetty

More information at [docs.travis-ci.com](http://docs.travis-ci.com/)

### Testing Principles

#### Narrative Tests

* tests should tell a story
* use `describe`, `context`, `it` and `specify`
* start with [empty tests](spec/narrative_spec.rb) that tell a story
* test output should read (more or less) like plain English

    > "the thing when first created has no name"
    >
    > "the thing when first created its default values includes the person who's creating it"
    >
    > "the thing when first created its default values contains that"
    >
    > "the thing when first created its default values contains this"

#### Unit vs. Integration

* test each Ruby class in isolation using mocked data as much as possible
* run integration tests--usually features--that test the class in context with the others

#### Speed

* the Hydra stack is slow, you have to work at it to make it fast
* mock, mock, mock
* write long feature tests and use them judiciously
* prefer `.new` to `.create`, or `.build` to `.create` with FactoryGirl

### Examples

#### Setup

Use [spec_helper.rb](spec/spec_helper.rb) to setup your testing environment

* randomize your tests
  - Randomize to catch tests that might be bleeding state into other tests. If your tests randomly fail, look to output of your specs: "Randomized with seed 37226"; Run with `rspec --seed 37226` to rerun the suite with the same conditions.
* load custom support classes and modules
* configure RSpec and extras like Device, DatabaseCleaner and Warden
* don't clean out Solr and Fedora unless you have to
* prefer Capybara's default driver to Poltergeist, which is slower

#### Models

[sample_afmodel_spec.rb](spec/models/sample_afmodel_spec.rb)

* properties
* default permissions
* required properties
* model settings

#### Indexers

[sample_indexer_spec.rb](spec/indexers/sample_indexer_spec.rb)

* tests the fields that are indexer in solr

#### Solr Document

[sample_solr_document_spec.rb](spec/models/sample_solr_document_spec.rb)

* special type of model class from Blacklight
* wraps a single document from a set of results returned from solr
* allows us to define methods for fields and any additional logic

#### Presenters

[sample_presenter_spec.rb](spec/presenters/sample_presenter_spec.rb)

* generated in the controller's response to a request
* takes three arguments: a solr document, an ability, an optional ActionDispatch::Request request context
* contains all the logic and metadata to render a page, such as fields, formatting, and additional presenters for contained resources
* most commonly used are the Sufia::WorkShowPresenter and Sufia::FileSetPresenter

#### Forms

[sample_form_spec.rb](spec/forms/sample_form_spec.rb)

* leverage Hydra::Editor capabilities from the hydra-editor gem
* handle translations of input from the parameters hash to values assigned to the object
* validates input
* defines the fields that you're allowed to edit, required fields, default values
* can also instantiate other presenters that are needed to render the edit page
* gets generated with CC or Sufia models

#### Actors

[sample_actor_spec.rb](spec/actors/sample_actor_spec.rb)

* a class type in CurationConcerns that performs update and create actions on models
* multiple actors are grouped into an "actor stack" that perform these actions in a specified order
* existing actors can be overridden to perform additional actions OR
* new actors can be added to the stack at a specific location in the order
* * Note: this must be done via the Sufia::ActorFactory service in Sufia or CurationConcerns::Actors::ActorFactory in CurationConcerns

#### Controllers

[sample_controller_spec.rb](spec/controllers/sample_controller_spec.rb)

* standard RSpec tests are used here
* Sufia and CurationConcerns' controllers set presenter and form classes, as well as curation concern types, so it's a good idea to test that here

#### Views

[sample_show_view_spec.rb](spec/views/sample_show_view_spec.rb)
[sample_edit_view_spec.rb](spec/views/sample_edit_view_spec.rb)

* you'll generally mock and stub everything as opposed to creating objects
* show and index views will have presenters and solr documents
* edit views will need forms

#### Jobs

[sample_job_spec.rb](spec/jobs/sample_job_spec.rb)

* conforms to the ActiveJob syntax
* two main actions: `perform_now` and `perform_later`
* similar to a service object architecture but with a messaging queue
* `queue_as` specifies the messaging service, i.e. Resque, SideKick, RabbitMQ, etc.

#### Services

[simple_service_spec.rb](spec/services/simple_service_spec.rb)
[hydra_service_spec.rb](spec/services/hydra_service_spec.rb)

* similar to jobs but without the messaging service
* one class performs one task, usually performed with `.call`
* good for performing complex tasks
* self-contained and easily testable
* can be invokved from anywhere, even within a job!

#### Helpers

[sample_helper_spec.rb](spec/helpers/sample_helper_spec.rb)

* use the built-in `helper` method
* mock/stub as needed

#### Search Builders

[sample_search_builder.rb](spec/search_builders/sample_search_builder_spec.rb)

* construct in Blacklight that organizes solr search behaviors into composable units
* assists with building a solr query
* assigned by a Blacklight-enabled controller, but can be used anywhere
* testing checks the solr query syntax but not the search results themselves

#### Features

[Home page feature test](spec/features/home_page_spec.rb)
[Sample messaging test](spec/features/sample_messages_spec.rb)
[Using different sessions](spec/features/test_with_sessions_spec.rb)

* executes the real page
* use Capybara matchers
* use Rails path helpers
* don't mock (generally) and instead create objects for your tests
* you may have to clean out the repository before each test

##### Speed Considerations

* keep the tests "long" because setup and tear-down for each test can be costly
* prefer Capybara's default driver over Poltergeist unless you need to explicitly test Javascript
* off-load as much Javascript testing to Jasmine (see below)

#### Javascript

* Use Jasmine to run unit tests for your Javascript files
* Use Poltergeist-enabled feature tests for integration testing
* ECMA6 is the preferred Javascript language style, but JQuery-type plugins or other styles are fine

##### Setting up and running Jasmine

Install the components

    bundle exec rails g jasmine:install

Run the CI tests

    bundle exec rake jasmine:ci

Or, startup a web browser to run tests and debug

    bundle exec rake jasmine

Then visit http://localhost:8888 and it will run the tests when the page loads. If you want to enable debugging,
open the web inspector console in the browser and reload the page. This will re-run the tests and stop at
any breakpoints identified with `debugger` in the JS code.

##### Integration with RSpec

If you want Jasmine to run its tests when you run RSpec, as part of the test suite, you'll need to use
a RSpec test that calls Jasmine and essentially parses its output to look for failures.

[jasmine_spec.rb](spec/javascripts/jasmine_spec.rb)

#### Routing

[sample_routes_spec.rb](spec/routing/sample_routes_spec.rb)

#### Lib

* catch-all for non-Rails related classes
* does not include any of RSpec's helper methods:
    * `get`, `show` etc. which are used in controllers
    * `rendered` from views
    * `helper` from helpers

#### Supporting Code

[support](spec/support)

* test classes
* helper methods
* any other supplemental code
