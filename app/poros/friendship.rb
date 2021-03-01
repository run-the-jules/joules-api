class Friendship
  #better class name, possibly
  attr_reader :user, :user_kwh, :friends_data
  def initialize(data)
    @user = data[:user_id]
    @user_kwh = data[:user_kwh]
    @friends_data = data[:friends]
  end
end