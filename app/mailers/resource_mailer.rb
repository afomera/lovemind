class ResourceMailer < ApplicationMailer

  def submission(resource)
    @resource = resource
    mail to: [@resource.user.email], subject: "Thanks for Adding #{@resource.name}"
  end
end
