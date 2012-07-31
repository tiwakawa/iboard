module CommonMethods
  extend ActiveSupport::Concern

  def owned_by?(user)
    self.user == user
  end
end
