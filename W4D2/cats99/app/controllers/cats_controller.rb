class CatsController < ApplicationController
  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    render :show
  end

  def new
    render :new
  end

  def create
    cat = Cat.create(cat_params)

    if cat.save
      redirect_to cat_url(cat)
    else
      render json: 'Dude, create a legit cat'
    end
  end

  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  def update
    @cat = Cat.find(params[:id])

    if @cat.update(cat_params)
      redirect_to cat_url(@cat)
    else
      render json: 'Update a legit cat'
    end
  end

  def destroy
    @cat = Cat.find(params[:id])
    if @cat.destroy
      redirect_to cats_url
    else
      render json: "Destroy a real cat"
    end
  end

  private
  def cat_params
    params.require(:cat).permit(:birth_date, :color, :name, :sex, :description)
  end

end
