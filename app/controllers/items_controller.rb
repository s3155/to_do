class ItemsController < ApplicationController
  before_action :find_list

  def new
    @item = Item.new
  end

  def create
    @item = @list.items.build(item_params)
    if @item.save
      redirect_to @list, notice: 'アイテムが作成されました'
    else
      render :new
    end
  end

  private

  def find_list
    @list = List.find(params[:list_id])
  end

  def item_params
    params.require(:item).permit(:name)
  end
end
