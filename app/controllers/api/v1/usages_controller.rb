class Api::V1::UsagesController < ApplicationController
  def show
    if params[:id].to_i != 0
      render json: UsagesSerializer.new(Usage.where(user_id: params[:id]))
    else
      raise_not_found!
    end
  end
end
