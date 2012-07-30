require 'spec_helper'

describe "Tops" do

  subject { page }

  describe "GET /tops" do
    before do
      visit tops_path
    end

    its(:current_path) { should == tops_path }
    it 'should have valid page title' do
      should have_selector('head title', text: 'iboard')
    end
    
  end
end
