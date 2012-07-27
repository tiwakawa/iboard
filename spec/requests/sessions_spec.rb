require 'spec_helper'

describe "Sessions" do

  before(:all) do
    FactoryGirl.create(:user)
    OmniAuth.config.test_mode = true
  end

  after(:all) do
    OmniAuth.config.test_mode = false
  end

  describe "GET /auth/twitter" do
    before do
      OmniAuth.config.mock_auth[:twitter] =
        { "provider" => "twitter", "info" => { "name" => "login_user", "nickname" => "login_user" } }
      visit "/auth/twitter"
    end

    it { page.body.should have_content "authenticated and logged in successfully." }
  end

  describe "GET /logout" do
    before do
      visit "/logout"
    end

    it { page.body.should have_content "logged out." }
  end

  describe "GET /auth/failure" do
    before do
      OmniAuth.config.mock_auth[:twitter] = :invalid_credentials
      visit "/auth/failure"
    end

    it { page.body.should have_content "twitter auth failed." }
  end
end
