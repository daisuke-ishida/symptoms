class SymptomsController < ApplicationController
    

    def index
        @q = Symptom.ransack(params[:symptom_id])
        @symptoms = @q.result
         my_symptoms = @symptoms.pluck(:symptom_id)
        
        target = Array.new
        my_symptoms.each do |e|
             target = target + Ownership.where(symptom_id: e).pluck(:user_id)
             @target = target.group_by(&:to_i).sort_by{|_,v|-v.size}.map(&:first)

         #  target.uniq!  #重複削除
         #targetは症状を持っている人IDの配列
    
    
         @users = User.find(@target).index_by(&:id).slice(*@target).values
        end
    end
    
    def new
        hostname = request.host
        if (/#{hostname}/.match(request.referrer))
          @symptom = Symptom.new
        else
          render :fail_new
        end
    end
    
    
    def create
        hostname = request.host
        if (/#{hostname}/.match(request.referrer))

            symptom = Symptom.new(symptom_params)
            symptom.save
        end
    end

private

    def symptom_params
        params.require(:symptom).permit(:name)
    end
end
