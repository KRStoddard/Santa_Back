class User < ApplicationRecord
    belongs_to :event
    validates :first_name, uniqueness: {scope: [:last_name, :event]}
    validates :first_name, :last_name, :email, presence: true
end