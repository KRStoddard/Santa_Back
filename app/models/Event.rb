class Event < ApplicationRecord
    belongs_to :admin
    has_many :users

    # matches users together so that each person is only matched once
    # it's not, like....SUPER efficient. But it works.
    def match
        gifted_array = []
        self.users.each do |user|
            while !user.match
                match = self.users.sample
                if ((!gifted_array.include? match.id) && (user.id != match.id))
                    user.update({match: match.id})
                end
            end
            gifted_array.push(user.match)
        end
    end
     
end