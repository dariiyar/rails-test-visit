class UsersController < ApplicationController
  before_action :import_params, only: :import

  def index
    @users = User.all
  end

  def destroy
    @user = User.find params[:id]
    @user.destroy
  end

  def import
    service.call
    @service.errors[:csv].present? ? render(json: {errors: @service.errors}, status: 422) : @users = User.all
  end

  private

  def import_params
    params.require(:file)
  end

  def service
    @service ||= ImporterService.new(params[:file])
  end
end
