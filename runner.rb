require "./rolodex"
require "./contact"

class Runner
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
    puts "Enter customer name:"
    name = gets.chomp
    @rolodex.create_contact(name)
  end

  def show_contacts
    puts "------------------------"
    puts "> Displaying all contacts:"
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

  def run
    done = false
    until done
      main_menu
      input = gets.chomp.to_i
      if input == 0
        done = true
      elsif input == 1
        add_contact
      elsif input == 2
        show_contacts
      elsif input == 3
        remove_contact
      elsif input == 4
        edit_contact
      end
      puts "------------------------"
    end
  end
end



runner = Runner.new
runner.run