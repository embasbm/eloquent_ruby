class SuperSecretDocument
  def initialize(original_document, time_limit_second)
    @original_document = original_document
    @time_limit_second = time_limit_second
    @create_time = Time.now
  end

  def time_expired?
    Time.now - @create_time >= @time_limit_second
  end

  def check_for_expiration
    raise 'Document no longer available' if time_expired?
  end

  def content
    check_for_expiration
    return @original_document
  end

  def title
    check_for_expiration
    return @original_document.title
  end

  def author
    check_for_expiration
    return @original_document.author
  end

  def page_layout
    check_for_expiration
    return @original_document.page_layout
  end

  def page_size
    check_for_expiration
    return @original_document.page_size
  end

  DELEGATED_METHODS = [:content, :words,:split]

  def method_missing(name, *args)
    check_for_expiration
    if DELEGATED_METHODS.include?(name)
      @original_document.send(name,*args)
    else
      super
    end

  end
end



string = 'Good morning, Mr. Phelps'
secret_string = SuperSecretDocument.new( string, 5 )
puts secret_string.split # Works fine
sleep 6
puts secret_string.split # Raises an exception









































