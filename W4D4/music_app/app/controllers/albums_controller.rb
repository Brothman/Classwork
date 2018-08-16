class AlbumsController < ApplicationController
  def new
    #I have to pass the band_id to the album as a hidden value in the field
    render :new
  end

  def create
    album = Album.new(album_params)

    if album.save
      redirect_to albums_url
    else
      flash.now[:errors] = album.errors.full_messages
      render :new
    end
  end

  def edit
    @album = Album.find_by(id: params[:id])
    render :edit
  end

  def update
    album = Album.find_by(id: params[:id])
    if album.update(album_params)
      redirect_to album_url(album)
    else
      flash.now[:errors] = album.errors.full_messages
      render :edit
    end
  end

  def show
    @album = Album.find_by(id: params[:id])
    render :show
  end

  def destroy
    Album.destroy(params[:id])
    redirect_to albums_url
  end

  private
  def album_params
    params.require(:album).permit(:title, :year, :style)
  end
end
