
require "./rolodex"
require "./contact"

class Runner
  CUSTOMER_FIELDS = ["name","email","notes"]
  def initialize
    @rolodex = Rolodex.new
  end

  def main_menu
    puts ""
    puts "Our Amazing CRM v.0.1"
    puts "**************************"
    puts "1. Add a contact"
    puts "2. See all contacts"
    puts "3. Remove a contact"
    puts "4. Edit a contact"
    puts "0. To Exit"
  end

  def add_contact
    customer_data   = []
    CUSTOMER_FIELDS.each do |field|
      puts "Enter customer #{field}:"
      customer_data << gets.chomp
    end

    if valid_email?( customer_data[1] )
      @rolodex.create_contact(*customer_data)
    else
      puts "Invalid email! Please enter a real email address or leave blank."
      add_contact
    end
  end

  def show_contacts
    puts "------------------------"
    puts "Displaying all contacts:"
    @rolodex.show_contacts
  end

  def remove_contact
    puts "Enter contact's ID to remove it:"
    id = gets.chomp.to_i
    @rolodex.remove_contact(id)
  end

  def edit_contact
    puts "Enter contact's ID to edit it:"
    id = gets.chomp.to_i
    puts "Enter contact's new contact name"
    new_name = gets.chomp
    
    @rolodex.edit_contact(id, new_name)
  end

  def valid_email?(email)
    /^[\w][\w\-\.]+@[\w\-]+([\w\-]+\.?)*[\w]{2,6}$/ =~ email
  end

  def run
    done = false
    until done
      main_menu
      input = gets.chomp.to_i

      if    input == 0 then done = true
      elsif input == 1 then add_contact
      elsif input == 2 then show_contacts
      elsif input == 3 then remove_contact
      elsif input == 4 then edit_contact
      end
      puts "------------------------"
    end
  end
end



runner = Runner.new
runner.run