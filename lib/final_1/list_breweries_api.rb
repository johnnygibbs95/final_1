class ListBreweriesAPI

    attr_reader :response

    def initialize        
        @response = HTTParty.get("https://api.openbrewerydb.org/breweries")
    end
    
end