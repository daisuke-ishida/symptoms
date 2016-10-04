module ApplicationHelper
  
  def active?(action_name)
      return "active" if action_name == params[:action]
  end
end
