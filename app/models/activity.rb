class Activity < ActiveRecord::Base
    belongs_to :dependent
    has_many :user_activities
    has_many :users, through: :user_activities

    validates :title, presence: true
end
