class UsersController < ApplicationController
  before_action :import_params, only: :import

  def index
    find_users
    respond_to do |format|
      format.html
      format.json { render 'users/import' }
    end
  end

  def destroy
    @user = User.find params[:id]
    @user.destroy
  end

  def import
    service.call
    @service.errors[:csv].present? ? render(json: {errors: @service.errors[:csv]}, status: 422) : find_users
  end

  private

  def find_users
    service = FindUserService.new(params)
    @users = service.call
  end

  def import_params
    params.require(:file)
  end

  def service
    @service ||= ImporterService.new(params[:file])
  end
end
