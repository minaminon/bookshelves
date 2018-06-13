class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  rescue_from Exception,with: :render_500
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ActionController::RoutingError, with: :render_404
  
  include SessionsHelper
  
  def render_500(e = nil)
    ExceptionNotifier.notify_exception(e, :env => request.env, :data => {:message => "500 error"})
    render template: 'errors/error_500', status: 500
  end
  
  def routing_error
    raise ActionController::RoutingError,params[:path]
  end
  
  def render_404(e = nil)
    
    if request.format.to_sym == :json
      render json: {error: '404'},status: :not_found
    else
      render 'errors/error_404',status: :not_found
    end
    
  end
  
  private
  
  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
end
