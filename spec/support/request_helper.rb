module RequestHelper
  def is_logged_in?
    !session[:user_id].nil?
  end

  def login(user = nil)
    user = create(:user) if user.nil?
    post login_path(login: { email: user.email,password: user.password })
  end

  def current_user
    User.find(request.session[:user_id])
  end
end
