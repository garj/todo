class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def set_task
    @task = Task.find(params[:id])
  end

  def index
    @tasks = Task.all
  end
  
  def new
    @task = Task.new
  end

  def create
    @task = Task.create(set_params)
    if @task.save
      redirect_to @task
    else
      #todo:what if validation fails
    end
  end

  def update
    @task.update(set_params)
    redirect_to @task
  end
  
   def destroy
     @task.destroy 
     redirect_to tasks_url
   end
  
  private
    def set_params
      task_params = params.require(:task).permit(:title, :description)     
    end
end
