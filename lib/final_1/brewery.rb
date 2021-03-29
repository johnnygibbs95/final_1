require_relative 'note'

class Brewery

    attr_reader :name, :brewery_type, :street, :city, :state, :postal_code, :country, :phone, :cli

    @@all = []

    def initialize(hash)
        @name = hash["name"]
        @brewery_type = hash["brewery_type"]
        @street = hash["street"]
        @city = hash["city"]
        @state = hash["state"]
        @postal_code = hash["postal_code"]
        @country = hash["country"]
        @phone = hash["phone"]
        @@all << self
    end

    def self.all
        @@all
    end

    def self.find_by_name(input)
        self.all.find {|brewery| brewery.name == input}
    end
    
    def information
        puts "
        You are viewing #{self.name}.
        "
        puts "This is a #{self.brewery_type.capitalize} brewery
        "
        puts "It's located at #{self.street}. #{self.city}, #{self.state} #{self.postal_code} #{self.country}.
        "
        puts "You can call them at #{self.phone}.
        "
    end

    def add_note(text)
        Note.new(text, self)
    end

    def notes
        Note.all.select{|notes| notes.brewery == self}
    end

    def show_notes
        puts "Notes added to #{self.name}:
        "
        notes.each{|note| puts "#{note.text}
        "}
    end

end
