class Api::V1::UsagesController < ApplicationController

  def show
    render json: UsagesSerializer.new(Usage.where(user_id: params[:id]))
  end
end
