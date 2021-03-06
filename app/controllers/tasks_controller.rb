class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def set_task
    @task = Task.find(params[:id])
  end

  def index
    @tasks_not_done = Task.where(is_done: false)
    @tasks_done = Task.where(is_done: true)
  end
  
  def new
    respond_to do |format|
      format.html {@task = Task.new}
      format.js
    end
  end

  def create
    @task = Task.create(set_params)
    if @task.save
      respond_to do |format|
        format.html {redirect_to @task}
        format.js {@newly_added_task = @task}
      end
    else
      render :new
    end
  end

  def update
    @task.update(set_params)
    redirect_to tasks_url
  end
  
  def complete
    @completed_tasks = Task.where(id: params[:is_done_ids])
    @completed_tasks.update_all(is_done: true)
    @completed_tasks = @completed_tasks.to_a

    respond_to do |format|
      format.html {redirect_to tasks_url}
      format.js 
    end
  end
  
  def destroy
    @task.destroy 
   
    respond_to do |format|
     format.html {redirect_to tasks_url}
     format.js
    end
  end
  
  private
    def set_params
      params.require(:task).permit(:title, :description, :is_done)     
    end
end
