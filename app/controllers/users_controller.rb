class UsersController < ApplicationController
  before_action :import_params, only: :import

  def index
    @users = User.all
  end

  def import
    service.call
    @users = User.all
  end
  private

  def import_params
    params.require(:file)
  end

  def service
    @service ||= ImporterService.new(params[:file])
  end
end
