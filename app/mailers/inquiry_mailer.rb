class InquiryMailer < ApplicationMailer
    default to: "berg7295karajan@gmail.com"
    default from: "berg7295karajan@gmail.com"
    
    def received_email(inquiry)
        @inquiry = inquiry
        mail(:subject => 'お問い合わせを承りました。')
    end
end
