class Friends
  #better class name, possibly
  attr_reader :user_id, :user_kwh, :end_date, :friends_data
  def initialize(data)
    @user_id = data[:user_id]
    @user_kwh = data[:user_kwh]
    @end_date = data[:end_date]
    @friends_data = data[:friends]
  end
end