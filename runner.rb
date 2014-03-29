require './contact'
require './rolodex'

class Runner
  def initialize
    @rolodex = Rolodex.new
  end

  def main_menu
    puts "\n*********************************"
    puts "***   Our Amazing CRM v.0.1   ***"
    puts "***  -----------------------  ***"
    puts "***  ( 1 ) Add a contact      ***"
    puts "***  ( 2 ) View all contacts  ***"
    puts "***  ( 3 ) Delete a contact   ***"
    puts "***  ( 4 ) Update a contact   ***"
    puts "***  ( 0 ) To Exit            ***"
    puts "*********************************\n\n"
    print "> "
  end

  def run
    done = false
    
    # Execution Loop
    until done
      main_menu
      input = gets.chomp.to_i

      puts ""

      if    input == 1 then add_contact
      elsif input == 2 then view_contacts
      elsif input == 3 then delete_contact
      elsif input == 4 then contact_validation
      else done = true
      end

    end
  end

  def add_contact
    puts "=== Add A Contact ==="
    
    puts "Enter new contact name:"
    name = gets.chomp.capitalize

    # Email with validation
    valid = false
    until valid
      puts "Enter email address for #{name}:"
      email = gets.chomp
      if valid_email?(email) || email == ''
        valid = 1
      else
        puts "\n\n--> AUTHENTICATION ERROR <--"
        puts "Sorry, the email address '#{email}' isn't a valid email address."
        puts "Please enter again (format name@domain.com) or leave blank.\n\n"
      end
    end
    
    puts "Add notes for #{name}:"
    notes = gets.chomp

    @rolodex.new_contact(name, email, notes)

    puts "\n'1' to add another, or 'Enter' to return to the main menu."
    input = gets.chomp.to_i
    add_contact if input == 1
  end

  def view_contacts 
    puts "=== Showing Contacts ==="
    @rolodex.view_contacts
    puts "> Press 'Enter' to return to the main menu."
    useless = gets.chomp
  end

  def delete_contact
    puts "=== Delete A Contact ==="
    puts "Enter an ID to delete it, or type '0' to view all contacts instead."
    input = gets.chomp.to_i
    if input == 0
      view_contacts
    else
      if @rolodex.user_exists?(input)
        @rolodex.delete_contact(input)
        puts "\nContact # #{input} successfully deleted."
        puts "'1' to delete another, or 'Enter' to delete another.\n"
        delete_more = gets.chomp.to_i
        delete_contact if delete_more == 1
      else
        puts "\nWe don't have a user by that ID! Please try again.\n"
        delete_contact
      end
    end
  end

  def contact_validation
    puts "=== Update A Contact ==="
    puts "Enter a user ID to select the user to update, or type '0' to view all contacts instead."
    id = gets.chomp.to_i
    puts "\n\n"
    if id == 0
      view_contacts
    else
      if @rolodex.user_exists?(id)
        update_contact(id)
      else
        puts "There is no contact with ID #{id}. Please try again."
        update_contact_validation
      end
    end
  end

  def update_contact(id)
    puts "> Enter the number of the field you wish to update:"
    @rolodex.show_contact_details(id)
    puts "( 0 ) Exit"
    field = gets.chomp.to_i
    if    field == 1 then update_name(id)
    elsif field == 2 then update_email(id)
    elsif field == 3 then update_notes(id)
    elsif field == 0;
    else
      puts "Invalid selection. Please try again, or press '0' to cancel."
      update_contact(id)
    end
  end

  def update_name(id)
    puts "Enter the new name for this user:"
    new_name = gets.chomp.capitalize
    @rolodex.update_name(id, new_name)

    
    update_more(id)
  end

  def update_email(id)
    puts "Enter the new email for this user:"
    new_email = gets.chomp
    @rolodex.update_email(id, new_email)

    update_more(id)
  end

  def update_notes(id)
    puts "Do you want to append new notes to this user, or overwrite the current notes with new ones?"
    puts "  ( 1 ) Append"
    puts "  ( 2 ) Overwrite"
    puts "  ( 0 ) Cancel"
    user_choice = gets.chomp.to_i

    puts "\nPlease enter new notes:\n"
    new_notes = gets.chomp

    if    user_choice == 1 then @rolodex.update_notes("append", id, new_notes)
    elsif user_choice == 2 then @rolodex.update_notes("overwrite", id, new_notes)
    end

    update_more(id)
  end

  def update_more(id)
    puts "\n\nContact #{id} successfully updated."
    puts "'1' to update more fields on this customer, or 'Enter' to return to the main menu\n"
    update_more = gets.chomp.to_i
    update_contact(id) if update_more == 1
  end


  def valid_email?(email)
    /^[\w][\w\-\.]+@[\w\-]+([\w\-]+\.?)*[\w]{2,6}$/ =~ email
  end


end

runner = Runner.new
runner.run