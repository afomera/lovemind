class CommentMailer < ApplicationMailer
  default from: "noreply@lovemind.info"

  def new_comment(resource, user)
    @resource = resource
    @user = user

    mail to: [@user.email], subject: "New Comment on #{@resource.name}"
  end
end
