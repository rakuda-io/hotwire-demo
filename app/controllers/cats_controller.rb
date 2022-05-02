class CatsController < ApplicationController
  before_action :set_cat, only: %i[ show edit update destroy ]

  PAGE = 10.freeze
  # GET /cats
  def index
    @search = Cat.ransack(params[:q])
    @search.sorts = 'id desc' if @search.sorts.empty?
    @cats = @search.result.page(params[:page]).per PAGE
  end

  def show
  end

  def new
    @cat = Cat.new
  end

  def edit
  end

  def create
    @cat = Cat.new(cat_params)

    if @cat.save
      redirect_to @cat, notice: "ねこを登録しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @cat.update(cat_params)
      redirect_to @cat, notice: "ねこを更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @cat.destroy
    redirect_to cats_url, notice: "ねこを削除しました。"
  end

  private
    def set_cat
      @cat = Cat.find(params[:id])
    end

    def cat_params
      params.require(:cat).permit(:name, :age)
    end
end
