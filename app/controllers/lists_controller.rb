class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update, :destroy]

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to @list
    else
      render 'new'
    end
  end

  def index
    @lists = List.all
  end

  def show
  end

  def edit
  end

  def update
    if @list.update(list_params)
      redirect_to lists_path, notice: 'リストが更新されました'
    else
      render 'edit'
    end
  end

  def destroy
    @list.destroy
    redirect_to lists_path, status: :see_other, notice: 'リストが削除されました'
  end
  

  private

  def set_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name, :description)
  end
end
