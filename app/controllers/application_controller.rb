class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end

include ApplicationHelper


def session_create
    session[:remember_token] = @user.id
    @current_user = @user
end


def authenticate_user
    if !self.current_user
      redirect_to new_session_path
    end
end
