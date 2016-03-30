Dir[File.dirname(__FILE__) + "/helpers/**/*.rb"].each {|f| require f }

FactoryGirl.definition_file_paths = [File.expand_path('../factories', __FILE__)]
FactoryGirl.find_definitions


RSpec.configure do |config|

  config.include Requests::JsonHelpers, type: :request
  config.include Requests::JsonHelpers, type: :controller
  config.include AuthHelper, :type => :controller  
  config.include FactoryGirl::Syntax::Methods

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  # Agrega los seeds para las pruebas
  config.before(:suite) do
    Rails.application.load_seed # loading seeds
  end

end
