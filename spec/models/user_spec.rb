require 'spec_helper'

describe User do
  before do
    subject { FactoryGirl.create(:user) }
  end

  describe "self.create_with_omniauth" do
    it "should create user with omniauth data" do
      auth = { "provider" => "twitter", "uid" => "12345", "info" => { "name" => "test", "nickname" => "test" } }
      user = User.create_with_omniauth(auth)

      user.provider.should eql auth["provider"]
      user.uid.should eql auth["uid"]
      user.name.should eql auth["info"]["name"]
      user.display_name.should eql auth["info"]["nickname"]
    end
  end
end
