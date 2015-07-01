require 'rails_helper'

describe IpCache do
  let(:cached_ip) { FactoryGirl.create(:ip_cache) }

  it 'should not be hellbanned by default' do
    expect(cached_ip.hellbanned).to be false
  end

  it 'should not be blacklisted by default' do
    expect(cached_ip.blacklisted).to be false
  end
end
