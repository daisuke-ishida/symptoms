class SymptomsController < ApplicationController
    def index
        @q = Symptom.ransack(params[:q])
        @symptoms = @q.request
        @user = User.owned(@symptoms)
    end
end
