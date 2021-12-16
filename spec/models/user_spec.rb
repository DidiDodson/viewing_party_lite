# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { should have_many(:party_invitees) }
    it { should have_many(:parties).through(:party_invitees) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password_digest) }
    it { should have_secure_password}
  end

  describe 'methods' do
    it 'excludes self from all users list' do
      user1 = User.create!(name: 'Jane Doe', email: 'email1@fakeemail.com', password: 'Abc123', password_confirmation: 'Abc123')
      user2 = User.create!(name: 'Raychaun Williams', email: 'email2@fakeemail.com', password: 'DFoo98', password_confirmation: 'DFoo98')
      user3 = User.create!(name: 'Tanya Rodriguez', email: 'email3@fakeemail.com', password: '63pOI', password_confirmation: '63pOI')
      expect(User.all_except(user1.id)).to include(user2, user3)
    end

    it 'confirms password was added correctly' do
      user = User.create(name: 'Trixie', email: 'trix@fake_cats.com', password: 'password123', password_confirmation: 'password123')

      expect(user).to_not have_attribute(:password)
      expect(user.password_digest).to_not eq('password123')
    end
  end
end
