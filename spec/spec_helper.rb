# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)

require 'rspec/rails'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[File.join(File.dirname(__FILE__), "support/**/*.rb")].each {|f| require f }

# Requires factories defined in spree_core
require 'spree/core/testing_support/factories'
require 'spree/core/testing_support/authorization_helpers'
require 'spree/core/testing_support/capybara_ext'

require 'factories'
require 'ffaker'

RSpec.configure do |config|
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true
  config.include Capybara::DSL
  config.include Spree::UrlHelpers
end

# monekypatch helper
CapybaraExt.module_eval do
  def targetted_select2(value, options)
    # find select2 element and click it
    find(options[:from]).find('ul.select2-choices').click
    select_select2_result(value)
  end

  def select_select2_result(value)
    #p %Q{$("div.select2-result-label:contains('#{value}')").mouseup()}
    sleep(1)
    find(:xpath, "//div[@class='select2-result-label' and contains(., '#{value}')]").click
  end

  def unselect2(value, options)
    id = find_label_by_text(options[:from])

    # generate select2 id
    options[:from] = "#s2id_#{id}"
    within "#{options[:from]} ul.select2-choices" do
      element = find(:xpath, "//li[@class='select2-search-choice' and contains(., '#{value}')]")
      element.find('a.select2-search-choice-close').click
      # wait for close to be effective
      sleep(1)
    end
  end
end
