require 'rails_helper'

RSpec::Matchers.define :has_param do |expected, val = nil|
  match do |actual|
    req = Rack::Request.new(actual)
    return req.params[expected].present? if val.nil?
    req.params[expected] == val
  end
end

describe Rack::ExtractUser do
  subject { described_class.new(->(env) { [200, env, 'app'] }) }
  let(:key) { access_key_for(id: 233, roles: %w(admin user dev)) }

  def env_with_key(key)
    env = Rack::MockRequest.env_for('http://example.org')
    req = Rack::Request.new(env)
    req.update_param(:access_key, key)
    env
  end

  it 'should give out roles correctly' do
    env = env_with_key(key)
    subject.call(env)
    expect(env).to has_param(:user_id, 233)
    expect(env).to has_param(:user_roles, %i(admin user dev))
  end

  it 'should do nothing for invalid keys' do
    env = env_with_key('invalid' + key)
    subject.call(env)
    expect(env).not_to has_param(:user_id, 233)
    expect(env).not_to has_param(:user_roles, %i(admin user dev))
  end
end
