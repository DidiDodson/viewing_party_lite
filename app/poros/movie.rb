class Movie
  attr_reader :image_url, :title, :runtime, :id, :vote_average, :genres, :overview

  def initialize(data)
    @image_url = image_gen(data[:poster_path])
    @title = data[:title]
    @runtime = data[:runtime]
    @id = data[:id]
    @vote_average = data[:vote_average]
    @genres = data[:genres]
    @overview = data[:overview]
  end

  def movie_genres
    genres.map do |genre|
      genre[:name]
    end
  end

  def image_gen(url)
    "https://image.tmdb.org/t/p/w500#{url}?api_key=#{ENV['movie_api_key']}"
  end
end
