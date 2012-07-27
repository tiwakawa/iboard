require 'spec_helper'

describe TopsController do

  describe "GET :index" do
    before do
      get :index
    end

    it { response.should be_success }
    it { should render_template :index }
  end

end
