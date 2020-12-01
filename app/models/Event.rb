class Event < ApplicationRecord
    belongs_to :admin
    has_many :users

end