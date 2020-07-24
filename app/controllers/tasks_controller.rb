class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task: params[:task])
    if @task.valid?
    @task.save
      redirect_to tasks_url
    else
      render 'tasks/new'
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task: task_params)
      redirect_to tasks_url
    else
      render 'tasks/edit'
    end
  end

  def destroy
    Task.find(params[:id]).destroy!
    redirect_to tasks_url
  end

  private

  def task_params
    params.require(:task).permit(:task)[:task]
  end

end