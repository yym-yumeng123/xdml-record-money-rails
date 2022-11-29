require 'rspec_api_documentation'
require 'api_documentation_helper'

RspecApiDocumentation.configure do |config|
  # 请求时我希望展示的
  config.request_headers_to_include = %w(Content-Type Cookie)
  # 响应时我希望展示的
  config.response_headers_to_include = %w(Content-Type Set-Cookie)
  # body 默认格式
  config.request_body_formatter = :json
  # 文档名字
  config.api_name = "旺财API文档"
  # 注释
  config.api_explanation = %q{
    请求数据格式：默认使用JSON格式，但也支持 application/x-www-form-urlencoded 格式。
    状态码：200表示成功，400表示失败，422表示表单数据校验不通过，其他状态码请查阅维基百科。
  }
end


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
