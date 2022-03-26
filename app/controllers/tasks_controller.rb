class TasksController < ApplicationController
   before_action :admin_or_correct_user,only: [:update, :destroy]
  
  def index
    @tasks = Task.all.order(created_at: :desc)
  end
  
  def show
    @task = Task.find(params[:id])
    @user = User.find(@task.user_id)
  end
  
  def new
  end
  
  def create
    @task = Task.new(name: params[:name], description:params[:description], user_id:params[:user_id])
   
    if @task.save
      flash[:success] = "タスクを新規作成しました。"
      redirect_to user_tasks_url
    else
      flash[:danger] = @task.errors.full_messages.join("<br>")
    end
  end
  
  def edit
    @task = Task.find(params[:id])
  end
  
  def update
    @task = Task.find(params[:id])
    @task.description = params[:description]
    @task.save
    redirect_to user_tasks_url
  end
  
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to user_tasks_url
  end
  
  def admin_or_correct_user
    @user = User.find(params[:user_id]) if @user.blank?
    unless current_user?(@user) || current_user.admin?
      flash[:danger] = "編集権限がありません。"
      redirect_to(root_url)
    end  
  end
  
end
