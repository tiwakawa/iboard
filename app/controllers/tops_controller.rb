class TopsController < ApplicationController
  def index
    @topics = Topic.all
  end
end
