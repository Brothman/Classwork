class ArtworksController < ApplicationController

  def index
    owned_artwork = Artwork.find_by(artist_id: params[:user_id])
    shared_artwork = User.find_by(id: params[:user_id]).shared_artworks

    if owned_artwork || shared_artwork
      render json: { owned_artwork: owned_artwork, shared_artwork: shared_artwork }
    else
      render json: 'artwork doesn''t exist'
    end
  end

  def show

  end

  def create

  end

  def update

  end

  def destroy

  end

end
