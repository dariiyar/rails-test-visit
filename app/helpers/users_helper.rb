module UsersHelper
  def order_by_options
    "<option value='' disabled selected>Sort By</option>"\
    "<option value='name:asc'>name(a-z)</option>"\
    "<option value='name:desc'>name(z-a)</option>"\
    "<option value='date:desc'>date(younger)</option>"\
    "<option value='date:asc'>date(older)</option>"\
    "<option value='number:desc'>number(higher)</option>"\
    "<option value='number:asc'>number(lower)</option>".html_safe
  end
end
