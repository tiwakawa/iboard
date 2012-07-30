require 'spec_helper'

describe User do

  describe "association" do
    before do
      FactoryGirl.create(:user)
    end
    it { should have_many :topics }
  end

  describe "self.create_with_omniauth" do
    let(:auth) { { "provider" => "twitter", "uid" => "12345", "info" => { "name" => "test", "nickname" => "test" } } }
    let(:user) { User.create_with_omniauth(auth) }

    subject { user }

    it { subject.provider.should eql auth["provider"] }
    it { subject.uid.should eql auth["uid"] }
    it { subject.name.should eql auth["info"]["name"] }
    it { subject.display_name.should eql auth["info"]["nickname"] }
  end

  describe "owner?(topic)" do
    let(:user)        { FactoryGirl.create(:user) }
    let(:my_topic)    { FactoryGirl.create(:topic, :user => user) }
    let(:other_topic) { FactoryGirl.create(:topic) }

    subject { user }

    it { user.owner?(my_topic).should be_true }
    it { user.owner?(other_topic).should_not be_true }
  end
end
