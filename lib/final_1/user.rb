class User
    attr_accessor :username

    @@all = []

    def self.all
        @@all
    end

    def self.create(username)
       user = self.new
       user.username = username
       self.all << user
       return user
    end

    def self.find_by_username(username)
        self.all.find{|user| user.username == username}
    end


    def self.find_or_create(username)
        self.find_by_username(username) || self.create(username)
    end
end