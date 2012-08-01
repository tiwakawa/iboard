module Ownerships
  def owned_by?(user)
    self.user == user
  end
end
