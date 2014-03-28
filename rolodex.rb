
class Rolodex
  def initialize
    @contacts = []
  end

  def create_contact(name, email, notes)
    contact = Contact.new
    contact.name = name.capitalize
    contact.email = email
    contact.notes = notes

    @contacts << contact
  end

  def show_contacts
    @contacts.each { |c| puts c }
  end

  def remove_contact(id)
    @contacts.delete_if { |c| c.id == id }
  end

  def edit_contact(id, new_name)
    @contacts.each do |c|
      if c.id == id
        c.name = new_name
      end
    end 
  end 
end