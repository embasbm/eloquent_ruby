class DocumentIdentifier
  attr_reader :folder, :name
  def initialize(folder, name)
    @folder = folder
    @name = name
  end

  def ==(other)
    return true if other.equal?(self)
    return false unless other.instance_of?(self.class)
    folder==other.folder && name == other.name
  end
end

first_id = DocumentIdentifier.new( 'secret/plans', 'raygun.txt' )
second_id = DocumentIdentifier.new('secret/plans', 'raygun.txt' )
puts "They are equal!" if first_id == second_id