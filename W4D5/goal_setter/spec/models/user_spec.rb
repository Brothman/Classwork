# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  username        :string
#  password_digest :string
#  session_token   :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  #Test 1. validations, 2.associations, 3. class methods

  context "validations" do
    context "presence validations" do
      it { should validate_presence_of(:username) }
      it { should validate_presence_of(:session_token) }
      it { should validate_presence_of(:password_digest) }
    end

    context "uniqueness validations" do
      it { should validate_uniqueness_of(:session_token) }
      it { should validate_uniqueness_of(:username) }
    end

    context "length validations" do
      it { should validate_length_of(:password).is_at_least(6) }
    end
  end

  context "associations" do
    it { should have_many(:goals) }
    it { should have_many(:comments).through(:goals) }
  end

  context "class methods" do
    let!(:user) { create(:user) }

    it "sets the password digest" do
      old_password_digest = user.password_digest
      user.password = "hello1"
      expect(user.password_digest).not_to eq(old_password_digest)
    end

    it "sets a session after initialization" do
      expect(subject.session_token).to be_present
    end

  end
end
