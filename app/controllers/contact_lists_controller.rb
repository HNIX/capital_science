class ContactListsController < ApplicationController
  def create
    @contact = Contact.find(params[:contact_id])
    @list = List.find(params[:list_id])
    @contact.lists << @list
  end
end