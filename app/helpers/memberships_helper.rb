module MembershipsHelper
	def membership_roles(membership)
	    roles = []
	    Membership::ROLES.each do |role|
	      roles << role.to_s.humanize if membership.public_send(:"#{role}?")
	    end
	    roles
	  end
end
