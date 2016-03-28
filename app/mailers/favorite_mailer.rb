class FavoriteMailer < ApplicationMailer
  default from: "tracyroyal@mac.com"

  def new_comment(user, post, comment)

#set three different headers to enable conversation threading in different email clients
     headers["Message-ID"] = "<comments/#{comment.id}@your-app-name.example>"
     headers["In-Reply-To"] = "<post/#{post.id}@your-app-name.example>"
     headers["References"] = "<post/#{post.id}@your-app-name.example>"

     @user = user
     @post = post
     @comment = comment

#mail method takes a hash of mail relevant information and prepares the email to be sent
     mail(to: user.email, subject: "New comment on #{post.title}")
   end

end
