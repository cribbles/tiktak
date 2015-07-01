require 'rails_helper'

describe User do
  let(:user) { FactoryGirl.build(:user) }

  it 'is valid with valid attributes' do
    expect(user).to be_valid
  end

  it 'should not be admin by default' do
    expect(user.admin).to be false
  end

  it 'should not be activated by default' do
    expect(user.activated).to be false
  end

  describe 'validations' do
    it 'requires email' do
      user.email = ' '
      expect(user).to_not be_valid
    end

    it 'limits email to 256 characters' do
      user.email = 'a' * 244 + '@example.com'
      expect(user).to_not be_valid
    end

    it 'rejects invalid email addresses' do
      invalid_addresses = %w(user@example,com user_at_foo.org user.name@example.
                             foo@bar_baz.com foo@bar+baz.com)
      invalid_addresses.each do |invalid_address|
        user.email = invalid_address
        expect(user).to_not be_valid
      end
    end

    it 'requires password' do
      user.password = user.password_confirmation = ' ' * 8
      expect(user).to_not be_valid
    end

    it 'requires password to be at least 8 characters' do
      user.password = user.password_confirmation = 'a' * 7
      expect(user).to_not be_valid
    end

    it 'saves email addresses as lower-case' do
      mixed_case_email = 'Foo@ExAMPle.CoM'
      saved_email = FactoryGirl.create(:user, email: mixed_case_email).email
      expect(saved_email).to eq(mixed_case_email.downcase)
    end

    it 'requires an unique email' do
      user.save
      dupe = FactoryGirl.build(:user)
      dupe.save
      expect(dupe).to_not be_valid
    end

    it 'requires a remember_digest to be authenticated' do
      authenticated = user.authenticated?(:remember, '')
      expect(authenticated).to be false
    end
  end
end
