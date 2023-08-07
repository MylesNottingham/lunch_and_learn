class Recipe
  attr_reader :id,
              :title,
              :url,
              :country,
              :image

  def initialize(recipe)
    @id = nil
    @title = recipe[:label]
    @url = recipe[:url]
    @country = recipe[:shareAs].split("/").last
    @image = recipe[:image]
  end
end
