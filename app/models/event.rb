class Event < ApplicationRecord

	has_and_belongs_to_many :attendees, :class_name => 'User', :join_table => :events_users
    # Un event peut avoir plusieurs attendees qui sont dans la class User et la joint table est là pour lister

    belongs_to :creator, :class_name => 'User'
    # Un event ne peut être créé que par un creator qui se trouve dans le tableau des users

    validates :description,  presence: true
    validates :date,  presence: true
    validates :place,  presence: true

end