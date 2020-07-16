class ListingInvitationsMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.account_invitations_mailer.invite.subject
  #
  def invite
    @listing_invitation = params[:listing_invitation]
    @listing = @listing_invitation.listing
    @invited_by = @listing_invitation.sender

    name = @listing_invitation.name
    email = @listing_invitation.email

    mail(
      to: "#{name} <#{email}>",
      from: "#{@invited_by.name} <#{Jumpstart.config.support_email}>",
      subject: I18n.t("account_invitations_mailer.invite.subject", inviter: @invited_by.name, account: @listing.title)
    )
  end
end