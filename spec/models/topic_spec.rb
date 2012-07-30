require 'spec_helper'

describe Topic do

  describe "associations" do
    it { should belong_to :user }
  end

  describe "validations" do
    it { should validate_presence_of :title }
    it { should ensure_length_of(:title).is_at_most(100) }
  end
end
