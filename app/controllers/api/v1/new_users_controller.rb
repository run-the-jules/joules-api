class Api::V1::NewUsersController < ApplicationController
  def index
    render json: MeterActivationFacade.new_user(params)
  end
end