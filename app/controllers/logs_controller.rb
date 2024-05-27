class LogsController < ApplicationController
  before_action :set_log, only: [:show]

  def index
    @logs = Log.includes(:user, :material).all
  end

  def show
  end

  private
  def set_log
    @log = Log.find(params[:id])
  end
end
