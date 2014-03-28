class Contact
  @@counter = 1000

  attr_accessor :notes, :name, :id

  def initialize
    @id = Contact.get_id
  end

  def to_s
    "ID: #{@id}\nName: #{@name}\nNotes: #{@notes}\n\t----"
  end

  def self.get_id
    @@counter += 1
    @@counter
  end
end