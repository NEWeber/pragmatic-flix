class FavoritesController < ApplicationController
before_action :set_movie
before_action :require_signin

  def create
    @movie.favorites.create!(user: current_user)
    redirect_to @movie
  end

  def destroy
    favorite = current_user.favorites.find_by(movie: @movie)
    favorite.destroy
    redirect_to @movie
  end

  private
    def set_movie
      @movie = Movie.find_by!(slug: params[:movie_id])
    end


end
