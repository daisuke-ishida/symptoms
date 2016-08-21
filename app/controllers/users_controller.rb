class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :followings, :followers]
  before_action :correct_user, only: [:edit, :update]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    s_array = params[:user][:ownerships]
    
    if @user.save
      flash[:success] = "Welcome to symptoms!"
      s_array.each do |s_id|
        if s_id != ""
          @user.own(@user, s_id.to_i)
        end
      end
    redirect_to @user
   else
     render 'new'
    end
  end
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc)
    @symptoms = @user.symptoms
  end
  
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated!"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def followings
    @user = User.find(params[:id])
    @users = @user.following_users(params[:followed_id])
  end
  
  def followers
    @user = User.find(params[:id])
    @users = @user.follower_users(params[:follower_id])
  end
  
  # def have
  #   @symptoms = Symptoms.current_user.own
  #   @user = User.find_by(symptoms_name: @symptoms.name)
  # end
  
  # def favorite
  #  @user = User.find(params[:id])
  #  @favorites = Favorite.where("user_id=?", @user)
  # end
  
  def search
    my_symptoms = current_user.symptoms.pluck(:id)
    
    #他のユーザーをtargetにidだけ拾ってくる
    target = Array.new
    my_symptoms.each do |e|
         target = (target + Ownership.where(symptom_id: e).pluck(:user_id))
         @target = target.group_by(&:to_i).sort_by{|_,v|-v.size}.map(&:first)  #同じ症状を持っている人を、一致した症状の数が多い順に並べる

  # 自分とフォローしている人は除く
  #  target.uniq!  #重複削除
    #targetは症状を持っている人IDの配列
    
     @target.delete(current_user.id)
     # @user = User.find(@target).index_by(&:id).slice(*@target).values
     @users = Kaminari.paginate_array(
                    User.find(@target).index_by(&:id).slice(*@target).values
                  ).page(params[:page]).per(10)
     end
    
    #@symptoms = Symptom.find(my_symptoms)
    # @users.each do |o|
    #  @others = Ownership.where(user_id: o).pluck(:symptom_id)
    #  @other_symptoms = Symptom.find(@others)
    # @total_symptoms = @symptoms + @other_symptoms
    #@users.each do |o|
    #　　@other_symptoms = o.symptoms
   # end
    
  end
  
  def startpickup
    @symptom = Symptom.new
  end
  
  def pickup
  #      @q = Symptom.ransack(params[:id])
  #      @symptoms = @q.result
         
    #     my_symptoms = @symptoms.pluck(:id)
        my_symptoms = params[:symptom][:ownerships]
        my_symptoms.delete("") #投稿フォームから空文字列がゴミで入るので除去Sym
        my_symptoms.compact!
        
        other_symptoms = []
        if request.post? then
          a = params[:symptom][:name]
          other_symptoms = Symptom.where('name like ?',"%#{a}%").pluck(:id)
        end
        target = Array.new
        my_symptoms.push(other_symptoms).flatten!.each do |e|
         target = target + Ownership.where(symptom_id: e).pluck(:user_id)
         @target = target.group_by(&:to_i).sort_by{|_,v|-v.size}.map(&:first)

    #targetは症状を持っている人IDの配列
    
    
     @users = Kaminari.paginate_array(
       User.find(@target).index_by(&:id).slice(*@target).values
       ).page(params[:page]).per(10)
     end
     
     
  #   target = Array.new
  #      other_symptoms.each do |e|
  #       target = target + Ownership.where(symptom_id: e).pluck(:user_id)
  #       @target = target.group_by(&:to_i).sort_by{|_,v|-v.size}.map(&:first)
         
  #    @users =Kaminari.paginate_array(
  #      User.find(@target).index_by(&:id).slice(*@target).values
  #     ).page(params[:page]).per(10)
  #    end
    end

  
  private
  
   def user_params
    params.require(:user).permit(:name, :age, :sex, :email, :password,
                                 :password_confirmation, {:symptoms => []})
   end
  
  def correct_user
    @user = User.find(params[:id])
    if @user !=current_user
      redirect_to root_path
    end
  end
end
