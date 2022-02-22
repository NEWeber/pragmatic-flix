module MoviesHelper

  def total_gross(movie)
    if movie.flop?
      return "Flop!"
    else
      return number_to_currency(movie.total_gross, precision:0)
    end
  end

  def year_of(movie)
    movie.released_on.year rescue "Missing release date"
  end

  def stars_display(movie)
    if movie.average_stars == 0.0
      "No reviews"
    else
      render "shared/stars", percent: movie.average_stars_as_percent
    end
  end
end
