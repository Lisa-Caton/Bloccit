class FavoriteMailer < ApplicationMailer
  default from: "lisacaton01@gmail.com"

  def new_comment(user, post, comment)
 
     # we set three different headers to enable conversation threading in different email clients.
     headers["Message-ID"] = "<comments/#{comment.id}@yBloccit.example>"
     headers["In-Reply-To"] = "<post/#{post.id}@Bloccit.example>"
     headers["References"] = "<post/#{post.id}@Bloccit.example>"
 
     @user = user
     @post = post
     @comment = comment
 
     # the mail method takes a hash of mail-relevant information
     mail(to: user.email, subject: "New comment on #{post.title}")
   end

end
