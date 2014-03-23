class Command

  def initialize(connection)
    @connection = connection
  end

  def is_command(txt)
    txt.match(/:{1}/) != nil
  end

  def issue com
    if com.match(/:category:/)
      Category.create(name: com.split(/:session:/)[1])
    elsif com.match(/:categories:/)
      category = Category.new
      category.set_connection @connection
      category.show_all
    end
  end

end
