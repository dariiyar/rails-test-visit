class UsersController < ApplicationController
  before_action :import_params, only: :import

  def index
    @users = User.all
  end

  def destroy
    @user = User.find params[:id]
    @user.destroy
    respond_to do |format|
      format.html { redirect_to root_path, flash: { success: t('flash.user.success.destroy') } }
      format.js   { render :layout => false }
    end
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
