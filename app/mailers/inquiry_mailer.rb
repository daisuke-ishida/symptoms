class InquiryMailer < ApplicationMailer
    default to: "送信先メアド"
    default from: "送信元メアド"
    
    def recieve_email(inquiry)
        @inquiry = inquiry
        mail(:subject => 'ユーザーに送信されるメールのタイトル')
    end
end
