class FindUserService
  def initialize(params)
    @params = params
  end

  def call
    find_users
  end

  private

  def find_users
    @users = User.filter(@params.slice(:starts_with, :date, :number, :in_description))
    order_by = @params[:order_by].present? ? @params[:order_by] : 'name:asc'
    return unless %w(name:asc name:desc date:desc date:asc number:desc number:asc).include? order_by
    order_by = order_by.split(':')
    @users = @users&.order_by(order_by[0], order_by[1]).page(@params[:page])
  end
end