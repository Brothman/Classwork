class ArtworkSharesController < ApplicationController

  # def index
  #   render json: ArtworkShare.all
  # end

  def create
    artwork_share = ArtworkShare.create(artwork_shares_params)

    if artwork_share
      render json: artwork_share
    else
      render json: artwork_share.errors.full_messages
    end
  end

  def destroy
    artwork_share = ArtworkShare.find_by(id: params[:id])

    if artwork_share
      artwork_share.destroy
      render json: artwork_share
    else
      render json: 'There aint no artwork share here, buddy'
    end
  end

  private

  def artwork_shares_params
    params.require(:artwork_share).permit(:viewer_id, :artwork_id)
  end

end
