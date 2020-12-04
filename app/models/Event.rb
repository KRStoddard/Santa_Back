class Event < ApplicationRecord
    belongs_to :admin
    has_many :users

    # matches users together so that each person is only matched once
    # it's not, like....SUPER efficient. But it works.
    def match
        not_gifted_array = self.users.map{|user| user.id}
        self.users.each do |user|
            while !user.match
                match = not_gifted_array.sample
                if (user.id != match)
                    not_gifted_array.delete(match)
                    user.update({match: match})
                end
            end
        end
    end
     
end