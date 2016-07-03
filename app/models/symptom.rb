class Symptom < ActiveRecord::Base
    has_many :ownerships , foreign_key: "name", dependent: :destroy
    has_many :users, through: :ownerships
    
    def had(symptom)
        ownerships.(symptom_name: :name)
    end
end
