# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @should_render_header = false
    redirect_to dashboard_path if user_signed_in?
    
  end

  
end
