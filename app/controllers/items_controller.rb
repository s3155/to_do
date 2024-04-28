class ItemsController < ApplicationController
  before_action :find_list

  def new
    @item = Item.new
  end

  def edit
    @item = Item.find(params[:id])
  end
  
  def create
    @item = @list.items.build(item_params)
    if @item.save
      redirect_to @list, notice: 'アイテムが作成されました'
    else
      render :new
    end
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to @list, notice: 'アイテムが更新されました'
    else
      render :edit
    end
  end
  
  def destroy
    @item = Item.find(params[:id])
    @list = @item.list
    @item.destroy
  
    # Redirect to the list's details page with a 303 See Other status code
    redirect_to list_path(@list), status: :see_other, notice: 'アイテムが削除されました'
  end
  
  
  

  def show
    # リソースの詳細を表示するための処理を記述
  end

  private

  def find_list
    @list = List.find(params[:list_id])
  end

  def item_params
    params.require(:item).permit(:name)
  end
end
