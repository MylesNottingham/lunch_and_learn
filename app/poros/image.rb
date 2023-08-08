class Image
  attr_reader :alt_tag,
              :url

  def initialize(params)
    @alt_tag = params[:alt_description]
    @url = params[:urls][:regular]
  end
end
