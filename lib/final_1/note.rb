class Note
    attr_reader :text, :brewery

    @@all = []

    def initialize(text, brewery)
        @text = text
        @brewery = brewery
        @@all << self
    end

    def self.all 
        @@all
    end

end

