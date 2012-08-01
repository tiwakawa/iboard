require 'spec_helper'

describe Topic do

  describe "associations" do
    it { should belong_to :user }
  end

  describe "validations" do
    it { should validate_presence_of :title }
    it { should ensure_length_of(:title).is_at_most(100) }
  end

  describe "owned_by?(user)" do
    let(:owner)   { FactoryGirl.create(:user) }
    let(:another) { FactoryGirl.create(:user) }
    let(:topic)   { FactoryGirl.create(:topic, user: owner) }

    subject { topic }

    it { topic.owned_by?(owner).should be_true }
    it { topic.owned_by?(another).should be_false }
  end
end
