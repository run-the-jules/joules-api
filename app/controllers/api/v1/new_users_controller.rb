class Api::V1::NewUsersController < ApplicationController
  def index
    # binding.pry
    render json: MeterActivationFacade.new_user(params)
  end
end