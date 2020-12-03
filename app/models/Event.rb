class Event < ApplicationRecord
    belongs_to :admin
    has_many :users

    def match
        gifted_array = []
        self.users.each do |user|
            while !user.match
                match = self.users.sample
                puts "hits match"
                if ((!gifted_array.include? match.id) && (user.id != match.id))
                    user.update({match: match.id})
                end
            end
            gifted_array.push(user.match)
        end
    end
     
end