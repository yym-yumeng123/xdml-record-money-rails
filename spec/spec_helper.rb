
# 写一个通用
module SpecTestHelper
  def sign_in(user = nil)
    user ||= create(:user, email: 'spec_test-helper@qq.com')
    post '/sessions', params: {email: user.email, password: user.password}
    user # return user
  end
end

# See https://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  # 使用模块
  config.include SpecTestHelper, :type => :request

  # rspec-expectations config goes here. You can use an alternate
  # assertion/expectation library such as wrong or the stdlib/minitest
  # assertions if you prefer.
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

=begin
  config.filter_run_when_matching :focus

  config.example_status_persistence_file_path = "spec/examples.txt"

  config.disable_monkey_patching!

  config.warnings = true

  if config.files_to_run.one?
    config.default_formatter = "doc"
  end

  config.profile_examples = 10

  config.order = :random

  Kernel.srand config.seed
=end
end
