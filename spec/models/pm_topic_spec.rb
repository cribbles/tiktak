require 'rails_helper'

describe PmTopic do
  let(:pm_topic) { FactoryGirl.create(:pm_topic) }

  it 'is valid with valid attributes' do
    expect(pm_topic).to be_valid
  end

  it 'should be created without a handshake by default' do
    expect(pm_topic.sender_handshake).to be false
    expect(pm_topic.recipient_handshake).to be false
    expect(pm_topic.handshake_declined).to be false
  end

  it 'should be initially unread by both parties' do
    expect(pm_topic.sender_unread).to be true 
    expect(pm_topic.recipient_unread).to be true
  end

  describe 'validations' do
    it 'requires a title' do
      pm_topic.title = nil
      expect(pm_topic).to_not be_valid
    end

    it 'limits a title to 140 characters' do
      pm_topic.title = 'x' * 141
      expect(pm_topic).to_not be_valid
    end
  end
end
