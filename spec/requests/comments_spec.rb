require 'spec_helper'

describe "Comments" do
  let(:user)    { FactoryGirl.create(:user) }
  let(:topic)   { FactoryGirl.create(:topic, user: user) }

  after do
    OmniAuth.config.test_mode = false
  end

  subject { page }

  describe "create comment" do
    let(:comment) { FactoryGirl.create(:comment, user: user, topic: topic) }
    let(:body)    { Forgery::Basic.text(at_most: 100) }

    before do
      twitter_login
      visit new_topic_comment_path(topic)
      fill_in :comment_body, with: body
      click_button :Save
    end

    it { page.should have_content("Comment was successfully created.") }
    it { page.should have_content(body) }
    it { page.current_path.should eql topic_path(topic) }
  end

  describe "destroy comment" do
    before do
      TopicsController.any_instance.stub(:current_user).and_return(user)
      CommentsController.any_instance.stub(:current_user).and_return(user)
      FactoryGirl.create(:comment, user: user, topic: topic)
      visit topic_path(topic)
      click_link 'destroy-comment'
    end

    it { page.should have_content("Comment was successfully deleted.") }
    it { page.current_path.should eql topic_path(topic) }
  end
end
