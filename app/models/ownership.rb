class Ownership < ActiveRecord::Base
  belongs_to :user, class_name: "User"
  belongs_to :symptom, class_name: "Symptom"
end
