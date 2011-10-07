class Ability
  include CanCan::Ability
  
  def initialize(user)
    user ||= User.new #guest user
    
    if user.admin? then
      can :manage, :all
    else
      can :read, Album do |album|
        return false if album.nil?
        user.has_album?(album)
      end
      can :manage, Picture do |pic|
        return false if pic.nil?
        user.has_album?(pic.album)
      end
    end
  end
end