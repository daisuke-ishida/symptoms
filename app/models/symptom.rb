class Symptom < ActiveRecord::Base
    has_many :ownerships , foreign_key: "symptom_id", dependent: :destroy
    has_many :users, through: :ownerships
    
    def had
        
        (symptom)
        ownerships.(symptom_name: :name)
    end
end
