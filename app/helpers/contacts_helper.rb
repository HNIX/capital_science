module ContactsHelper

    def contact_roles(contact)
        roles = ""
        
        Membership::ROLES.each do |role|
          roles << role.to_s.humanize if contact.public_send(:"#{role}?")
        end

        roles
    end

end