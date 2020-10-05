module AccountsHelper
  def account_avatar(account, options = {})
    size = options[:size] || 48
    classes = options[:class]

    if account.personal? && account.owner_id == current_user&.id
      image_tag avatar_url_for(account.users.first, options), class: classes

    elsif account.avatar.attached?
      image_tag account.avatar.variant(combine_options: {
        thumbnail: "#{size}x#{size}^",
        gravity: "center",
        extent: "#{size}x#{size}"
      }),
        class: classes
    else
      content = content_tag(:span, account.name.to_s.first, class: "initials")

      if options[:include_user]
        content += image_tag(avatar_url_for(current_user), class: "avatar-small")
      end

      content_tag :span, content, class: "avatar bg-blue-500 #{classes}"
    end
  end

  def account_user_roles(account, account_user)
    roles = []
    roles << "Owner" if account_user.respond_to?(:user_id) && account.owner_id == account_user.user_id
    AccountUser::ROLES.each do |role|
      roles << role.to_s.humanize if account_user.public_send(:"#{role}?")
    end
    roles
  end

  def account_admin?(account, account_user)
    AccountUser.find_by(account: account, user: account_user).admin?
  end

  def view_count(user, listing)
    Ahoy::Event.where(name: "Viewed listing", user_id: user.id).where_props(id: listing.id).count
  end

  def download_count(user, listing)
    public_count = Ahoy::Event.where(name: "Downloaded public document", user_id: user.id).where_props(id: "#{listing.id}").count
    secure_count = Ahoy::Event.where(name: "Downloaded secure document", user_id: user.id).where_props(id: "#{listing.id}").count

    downloads = public_count + secure_count

    return downloads
  end
end
