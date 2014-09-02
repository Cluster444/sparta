class Ability
  include CanCan::Ability

  def initialize(user)
    can([:read, :update], Player, user_id: user.id)
    can(:manage, City, :player => {user_id: user.id})
    can(:manage, Scout, :city => {:player => {user_id: user.id}})
    can(:manage, Raid, :city => {:player => {user_id: user.id}})
  end
end
