class TasksController < ApplicationController
  def show
    @task = Task.find(params[:board_id])
  end

  def new
    board = Board.find(params[:board_id])
    @task = board.tasks.build
  end

  def create
    board = Board.find(params[:board_id])
    @task = board.tasks.build(task_params)
    @task.user_id = current_user.id
    @task.board_id = board.id
    if @task.save!
      redirect_to board_path(board), notice: '保存完了'
    else
      flash.now[:error] = '保存失敗'
      render :new
    end
  end

  def edit
    @task = Task.find(params[:board_id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to board_task_path(@task), notice: '更新完了'
    else
      flash.now[:error] = '更新完了'
      render :edit
    end
  end

  def destroy
    task = Task.find(params[:board_id])
    task.destroy!
    redirect_to root_path, notice: '削除完了'
  end

  private
  def task_params
    params.require(:task).permit(:title, :content, :deadline, :eyecatch)
  end
end