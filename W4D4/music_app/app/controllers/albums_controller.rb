class AlbumsController < ApplicationController
  def new
    #I have to pass the band_id to the album as a hidden value in the field
    @band_id = params[:band_id]
    render :new
  end

  def create
    album = Album.new(album_params)

    if album.save
      redirect_to album_url(album)
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
    album = Album.find(params[:id])
    album.destroy
    redirect_to band_url(album.band_id)
  end

  private
  def album_params
    params.require(:album).permit(:title, :year, :style, :band_id)
  end
end
