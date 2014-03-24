class Command

  def initialize(connection)
    @connection = connection
  end

  def is_command(txt)
    txt.match(/:{1}/) != nil
  end

  def issue com
    if com.match(/:category:/)
      cat = com.split(/:category:/)[1]
      if Category.find_by_name(cat)

      elsif Category.find_by_id(cat)

      else
        Category.create(name: com.split(/:category:/)[1])
      end
    elsif com.match(/:categories:/)
      category = Category.new
      category.set_connection @connection
      category.show_all
    end
  end

end
