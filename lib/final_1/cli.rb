require_relative "user"

class CLI
    attr_reader :brewery

    def initialize
        ListBreweriesAPI.new.response.each {|brewery_hash| Brewery.new(brewery_hash)}
        @prompt = TTY::Prompt.new
        login
    end

    def login
        puts "
        
        Hello there! Welcome to Open Brewery DB, where you can find great new breweries to try out!
        "
        input = @prompt.yes?("Do you you already have a username?")
        case input
        when true
            input = @prompt.ask("Please type your username here. →")
            @user = User.find_by_username(input)
            start
        when false
            input = @prompt.yes?("Would you like to create a username?")
            case input 
            when true
                input = @prompt.ask("Please create a username here. →")
                @user = User.create(input)
                start
            when false
                input = @prompt.enum_select("Please choose what you'd like to do next", ["Login", "Exit"])
                case input 
                when "Login"
                    login
                when "Exit"
                    exit
                end
            end
        end
    end
    
    def start
        if @user
            input = @prompt.yes?("Hello #{@user.username}! Would you like to see all the defferent breweries?")
            case input 
            when true
                first_menu
            when false
                exit
            end 
        else
            puts "That username does not exist."
            input = @prompt.enum_select("Please choose what you'd like to do next", ["Login", "Exit"])
                case input
                when "Login"
                    login
                when "Exit"
                    exit
                end


        end
    end

    def first_menu
        input = @prompt.select("Which brewery would you like to find out more about?", all_breweries(Brewery.all))
        @brewery = Brewery.find_by_name(input)
        brewery_info
        second_menu
    end

    def second_menu
        input = @prompt.enum_select("Please choose what you'd like to do next", 
            ["Learn about a different brewery", 
            "Add a note to #{@brewery.name}'s information", 
            "See #{@brewery.name}'s notes",
            "Logout", 
            "Exit"])
            case input
            when "Learn about a different brewery"
                first_menu
            when "Add a note to #{@brewery.name}'s information"
                input = @prompt.ask("Type the note you'd like to add here:")
                @brewery.add_note(input)
                @brewery.show_notes
                second_menu
            when "See #{@brewery.name}'s notes"
                @brewery.show_notes
                second_menu
            when "Logout"
                login
            when "Exit"
                exit
            end
    end

    def brewery_info        
        @brewery.information
    end

    def all_breweries(breweries)
        breweries.map{|brewery| brewery.name} 
    end

    def exit
        input = @prompt.yes?("Would you like to exit?")
        case input
        when true
            puts "Thanks for checking out Brewery DB!"
        when false
            if @user
            input = @prompt.enum_select("Please choose what you'd like to do next", ["See all the breweries", "Logout", "Exit"])
                case input
                when "See all the breweries"
                    first_menu
                when "Logout"
                    login
                when "Exit"
                    exit
                end
            else
                login
            end
        end
    end
end