class PokemonController < ApplicationController

  def index

  end

  def show

    pokeapi = HTTParty.get("http://pokeapi.co/api/v2/pokemon/#{params[:id]}")
      pokebody = JSON.parse(pokeapi.body)
      @name = pokebody["name"]
      @types = pokebody["types"].map {|type| type["type"]["name"]}
      @id = pokebody["id"]


    giphy = HTTParty.get("https://api.giphy.com/v1/gifs/search?api_key=#{ENV['GIPHY_KEY']}&q=#{@name}&rating=g")
      giphybody = JSON.parse(giphy.body)
      @url = giphybody["data"].sample["images"]["downsized_medium"]["url"]

    json =  {
      "id": @id,
      "name": @name,
      "types": @types,
      "gif_url": @url
    }

    respond_to do |format|
      format.html
      format.json do
        render json: json
      end
    end

  end

end
