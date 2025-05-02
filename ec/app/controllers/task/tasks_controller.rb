class Task::TasksController < ApplicationController
  def index
    user_id = session[:user_id]

    get_user_tasks_service = Task::GetUserTasksService.new

    page = params[:page] ||= 1
    
    per_page = params[:per_page] ||= 10

    priority_sort = params[:priority] ||= Usecases::Task::GetTasksCriteria::DESC
    created_sort = params[:created] ||= Usecases::Task::GetTasksCriteria::DESC
    updated_sort = params[:updated] ||= Usecases::Task::GetTasksCriteria::DESC
    @user_name = session[:user_name]
    tasks_hash = get_user_tasks_service.get_tasks(user_id, page, per_page, priority_sort, created_sort, updated_sort)
    @tasks = tasks_hash[:tasks]
    @total = tasks_hash[:total]
    @total_pages = tasks_hash[:total_pages]
  end

  def new
  end

  def create
    user_id = session[:user_id]
    task_name = params[:task_name]
    task_description = params[:task_description]
    task_priority = params[:task_priority]
    task_status = params[:task_status]

    create_task_service = Task::CreateTaskService.new
    create_task_service.create_task(user_id, task_name, task_description, task_priority, task_status)

    redirect_to action: :index
  end

  def edit
    task_id = params[:task_id]
    get_user_tasks_service = Task::GetUserTasksService.new
    @task = get_user_tasks_service.get_task_by_id(task_id)
  end

  def update
    task_id = params[:task_id]
    task_name = params[:task_name]
    task_description = params[:task_description]
    task_priority = params[:task_priority]
    task_status = params[:task_status]

    update_task_service = Task::UpdateTaskService.new
    update_task_service.update_task(task_id, task_name, task_description, task_priority, task_status)

    redirect_to action: :index
  end

  def delete
    task_id = params[:task_id]
    delete_task_service = Task::DeleteTaskService.new
    delete_task_service.delete_task(task_id)
  end


end
