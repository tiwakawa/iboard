require 'spec_helper'

describe TopicsController do

  def valid_attributes
    { title: Forgery::Basic.text(:at_most => 10) }
  end
  
  def valid_session
    {}
  end

  describe "GET :show" do
    before do
      topic = FactoryGirl.create(:topic)
      get :show, :id => topic.id
    end

    it { response.should be_success }
    it { should render_template :show }
  end

  describe "GET :new" do
    context "logged in" do
      before do
        controller.stub(:login_required) { true }
        controller.stub(:current_user).and_return(FactoryGirl.create(:user))
        get :new
      end

      it { response.should be_success }
      it { should render_template :new }
      it { assigns(:topic).should be_a_new(Topic) }
    end

    context "not logged in" do
      before do
        get :new
      end

      it { response.should_not be_success }
      it { response.should redirect_to root_path }
    end
  end

  describe "POST :create" do
    before do
      controller.stub(:login_required) { true }
      controller.stub(:current_user).and_return(FactoryGirl.create(:user))
    end

    describe "with valid params" do
      it "creates a new Topic" do
        expect {
          post :create, { topic: valid_attributes }, valid_session
        }.to change(Topic, :count).by(1)
      end

      it "assigns a newly created topic as @topic" do
        post :create, { topic: valid_attributes }, valid_session
        assigns(:topic).should be_a(Topic)
        assigns(:topic).should be_persisted
      end

      it "redirects to the created topic" do
        post :create, { topic: valid_attributes }, valid_session
        response.should redirect_to root_path
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved topic as @topic" do
        Topic.any_instance.stub(:save).and_return(false)
        post :create, { topic: {} }, valid_session
        assigns(:topic).should be_a_new(Topic)
      end

      it "re-renders the 'new' template" do
        Topic.any_instance.stub(:save).and_return(false)
        post :create, { topic: {} }, valid_session
        response.should render_template :new
      end
    end
  end

  describe "DELETE destroy" do
    let!(:topic) { FactoryGirl.create(:topic) }
    before do
      controller.stub(:login_required) { true }
      controller.stub(:owner_required) { true }
      controller.stub(:current_user).and_return(FactoryGirl.create(:user))
    end

    it "destroys the requested topic" do
      expect {
        delete :destroy, { id: topic.to_param }, valid_session
      }.to change(Topic, :count).by(-1)
    end

    it "redirects to root_path" do
      delete :destroy, { id: topic.to_param }, valid_session
      response.should redirect_to root_path
    end
  end
end
