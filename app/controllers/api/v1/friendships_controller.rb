class Api::V1::FriendshipsController < ApplicationController
  def index
    render json: FriendshipsFacade.compare(params[:id], params[:friend_ids])
  end
  
  def create
    friendship = Friendship.new(friendship_params)
    if friendship.save
      render json: FriendshipSerializer.new(friendship), status: :created
    else
      render json: { data: friendship.errors }, status: :conflict
    end
  end
  
  private 
  
  def friendship_params
    params.require(:friendship).permit(:user_id, :following_id)
  end
end