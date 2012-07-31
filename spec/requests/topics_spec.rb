require 'spec_helper'

describe "Topics" do

  subject { page }

  describe "GET /topics/show" do
    let(:topic) { FactoryGirl.create(:topic) }
    before do
      visit topic_path(topic)
    end

    its(:current_path) { should eql topic_path(topic) }
    it { should have_content(topic.title) }
    it { should have_content(topic.user.display_name) }
    it { should have_content("No Comment") }
  end

  describe "create topic" do
    let(:title) { Forgery::Basic.text(:at_most => 10) }
    before do
      twitter_login
      visit new_topic_path
      fill_in :topic_title, with: title
      click_button :Save
    end

    after do
      OmniAuth.config.test_mode = false
    end

    it { page.should have_content("Topic was successfully created.") }
    it { page.should have_content(title) }
    it { page.current_path.should eql root_path }
  end

  describe "destroy topic" do
    let(:user)  { FactoryGirl.create(:user) }
    let(:topic) { FactoryGirl.create(:topic, user: user) }
    before do
      TopicsController.any_instance.stub(:current_user).and_return(user)
      visit topic_path(topic)
      click_link 'destroy-topic'
    end

    after do
      OmniAuth.config.test_mode = false
    end

    it { page.should have_content("#{topic.title} was successfully deleted.") }
    it { page.current_path.should eql root_path }
  end
end
