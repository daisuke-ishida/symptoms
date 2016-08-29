class InquiryController < ApplicationController
    
    def index
        @inquiry = Inquiry.new
        render 'index'
    end
    
    def confirm
        @inquiry = Inquiry.new(inquiry_params)
        if @inquiry.valid?
            render 'confirm'
        else
            render 'index'
        end
    end
    
    def thanks
        @inquiry = Inquiry.new(inquiry_params)
        InquiryMailer.received_email(@inquiry).deliver
        
        flash[:notice] = "お問い合わせ頂き、ありがとうございました。"
        render :action => 'thanks'
    end
    
    private
    def inquiry_params
        params.require(:inquiry).permit(:name, :email, :message)
    end
end
