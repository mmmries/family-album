module ApplicationHelper
  ##getter/setter for the current user
  def current_user
    if @current_user.nil? then
      @current_user = User.find(session[:user_id]) unless session[:user_id].nil?
    end
    @current_user
  end
  
  def current_user=(user_id)
    session[:user_id] = user_id
  end
  
  ##some templating helpers
  def main_box(title)
    buff = "<h1 class='top-rounded-corners'>#{title}</h1><div class='bottom-rounded-corners mainbox'>".html_safe
    buff.concat(yield)
    buff.safe_concat("</div>")
    return buff  
  end
  
  
end
