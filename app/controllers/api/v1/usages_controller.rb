class Api::V1::UsagesController < ApplicationController
  def show
    render json: UsagesSerializer.new(UsagesFacade.utility_info(params[:id]))
  end
end
