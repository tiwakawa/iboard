require 'spec_helper'

describe Comment do

  describe "associations" do
    it { should belong_to :user }
    it { should belong_to :topic }
  end

  describe "validations" do
    it { should validate_presence_of :body }
    it { should ensure_length_of(:body).is_at_most(300) }
  end
end
