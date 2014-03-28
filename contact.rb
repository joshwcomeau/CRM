class Contact
  @@counter = 1000

  attr_accessor :notes, :name, :email, :id, :created, :modified

  def initialize
    @id = Contact.get_id
    @created = Time.new()
    @modified = @created
  end

  def to_s
    " > ID: #{@id}\n > Name: #{@name}\n > Email: #{@email}\n > Notes: #{@notes}\n\t----
    \nContact created: #{@created}\nLast Modified: #{@modified}"
  end

  def self.get_id
    @@counter += 1
    @@counter
  end
end