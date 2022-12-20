# frozen_string_literal: true

class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @should_render_header = true
    @boards = Board.order(:created_at)
  end
end
