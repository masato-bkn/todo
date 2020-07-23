class TaskController < ApplicationController
  def index
    @tasks = Task.all
  end

  def create
    @task = Task.new(task: params[:task])
    if @task.valid?
      @task.save
      redirect_to root_url
    end
  end
end