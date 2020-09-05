module MembershipsHelper
  def membership_roles(listing, membership)
    roles = []
    roles << "Owner" if membership.respond_to?(:user_id) && listing.owner_id == membership.user_id
    Membership::ROLES.each do |role|
      roles << role.to_s.humanize if membership.public_send(:"#{role}?")
    end
    roles
  end
end
