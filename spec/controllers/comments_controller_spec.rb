require 'spec_helper'

describe CommentsController do
  let(:topic) { FactoryGirl.create(:topic) }
  let(:user)  { FactoryGirl.create(:user) }

  def valid_attributes
    { comment: { body: Forgery::Basic.text(at_most: 100) }, user_id: user.id, topic_id: topic.id }
  end
  
  def invalid_attributes
    { comment: {}, user_id: user.id, topic_id: topic.id }
  end

  def valid_session
    {}
  end

  def post_comment_with(attributes)
    post :create, attributes, valid_session
  end

  describe "GET :new" do
    context "logged in" do
      before do
        logged_in_for_controller(controller, user)
        get :new, topic_id: topic.id
      end

      it { response.should be_success }
      it { should render_template :new }
      it { assigns(:comment).should be_a_new(Comment) }
    end

    context "not logged in" do
      before do
        get :new, topic_id: topic.id
      end

      it { response.should_not be_success }
      it { response.should redirect_to root_path }
    end
  end

  describe "logged in" do
    before do
      logged_in_for_controller(controller, user)
    end

    describe "POST :create" do
      describe "with valid params" do
        before do
          post_comment_with(valid_attributes)
        end

        it "creates a new Comment" do
          expect {
            post_comment_with(valid_attributes)
          }.to change(Comment, :count).by(1)
        end

        it "assigns a newly created comment as @comment" do
          assigns(:comment).should be_a(Comment)
          assigns(:comment).should be_persisted
        end

        it "redirects to the created comment" do
          response.should redirect_to topic_path(topic)
        end
      end

      describe "with invalid params" do
        before do
          Comment.any_instance.stub(:save).and_return(false)
          post_comment_with(invalid_attributes)
        end

        it "assigns a newly created but unsaved comment as @comment" do
          assigns(:comment).should be_a_new(Comment)
        end

        it "re-renders the 'new' template" do
          response.should render_template :new
        end
      end
    end

    describe "DELETE destroy" do
      before do
        @comment = FactoryGirl.create(:comment, user_id: user.id, topic_id: topic.id)
      end

      it "destroys the requested comment" do
        expect {
          delete :destroy, { id: @comment.to_param, user_id: user.id, topic_id: topic.id }, valid_session
        }.to change(Comment, :count).by(-1)
      end

      it "redirects to the comments list" do
        delete :destroy, { id: @comment.to_param, user_id: user.id, topic_id: topic.id }, valid_session
        response.should redirect_to topic_path(topic)
      end
    end
  end
end
