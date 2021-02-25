class Api::V1::UsagesController < ApplicationController
  def show
    render json: UsagesSerializer.new(UsagesFacade.kwh(params[:id]))
    #usage = Usage.new(usage_params)
  end
end
