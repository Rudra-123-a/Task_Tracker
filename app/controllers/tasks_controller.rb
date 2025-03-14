class TasksController < ApplicationController
  before_action :authenticate_user! # Ensures user authentication before accessing tasks
  before_action :set_task, only: [:edit, :update, :destroy]

  # List all tasks for the logged-in user
  def index
    @tasks = current_user.tasks
  end

  # Display form for creating a new task
  def new
    @task = Task.new
  end

  # Create and save a new task
  def create
    @task = current_user.tasks.build(task_params) # Assign task to current user
    if @task.save
      redirect_to tasks_path, notice: 'Task created successfully!'
    else
      flash.now[:alert] = 'Failed to create task'
      render :new, status: :unprocessable_entity
    end
  end

  # Display form for editing an existing task
  def edit
    # `@task` is already set in `before_action :set_task`
  end

  # Update an existing task
  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: 'Task updated successfully!'
    else
      flash.now[:alert] = 'Failed to update task'
      render :edit, status: :unprocessable_entity
    end
  end

  # Delete a task
  def destroy
    @task = current_user.tasks.find(params[:id])
    if @task.destroy
      redirect_to tasks_path, notice: 'Task deleted successfully!'
    else
      redirect_to tasks_path, alert: 'Failed to delete task'
    end
  end

  private

  # Find the task for edit, update, and destroy actions
  def set_task
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to tasks_path, alert: 'Task not found or does not belong to you'
    end
  end

  # Permit only title and description parameters
  def task_params
    params.require(:task).permit(:title, :description)
  end
end
