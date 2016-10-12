require 'rspec/expectations'

require 'rack/request'
require 'rack/mock'
require_relative '../../lib/middleware/extract_user.rb'

class MockRedis < Hash
  def set_access_key(key, id: 0, roles: [])
    self["access_key:#{key}"] = "#{id}:#{roles.join(',')}"
  end

  def get(key)
    self[key]
  end
end

redis = MockRedis.new
Rack::ExtractUser.class_eval do
  define_method :remote_storage do
    redis
  end
end

RSpec::Matchers.define :has_param do |expected, val = nil|
  match do |actual|
    req = Rack::Request.new(actual)
    return req.params[expected].present? if val.nil?
    req.params[expected] == val
  end
end

describe Rack::ExtractUser do
  let(:key) { rand(100_000).to_s }
  let(:env) {
    env = Rack::MockRequest.env_for('http://example.org')
    req = Rack::Request.new(env)
    req.update_param(:access_key, key)
    env
  }
  subject { described_class.new(->(env) { [200, env, 'app'] }) }

  it 'should give out roles correctly' do
    redis.set_access_key(key, id: 233, roles: %w(admin user dev))
    subject.call(env)
    expect(env).to has_param(:user_id, 233)
    expect(env).to has_param(:user_roles, %i(admin user dev))
  end

  it 'should do nothing for invalid keys' do
    redis.set_access_key(key.to_i + 10, id: 233, roles: %w(admin user dev))
    subject.call(env)
    expect(env).not_to has_param(:user_id, 233)
    expect(env).not_to has_param(:user_roles, %i(admin user dev))
  end
end
