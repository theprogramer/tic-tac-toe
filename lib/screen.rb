class Screen
  def self.clear
    system 'clear' or system 'cls'
  end

  def self.message(msg = '', color = :info)
    send color, msg
  end

  def self.info(msg = '')
    puts blue(msg)
  end

  def self.error(msg = '')
    puts red(msg)
  end

  def self.success(msg = '')
    puts green(msg)
  end

  def self.normal(msg = '')
    puts white(msg)
  end

  def self.white(msg = '')
    "\e[29m#{msg}\e[0m"
  end

  def self.green(msg = '')
    "\e[32m#{msg}\e[0m"
  end

  def self.red(msg = '')
    "\e[31m#{msg}\e[0m"
  end

  def self.blue(msg = '')
    "\e[34m#{msg}\e[0m"
  end

  def self.brown(msg = '')
    "\e[33m#{msg}\e[0m"
  end

  def self.choice(options = [], msg = '', err = '')
    option = ''
    valid_options = options
    until valid_options.include? option
      message msg, :info
      message err, :error unless option == ''
      if options.first.class == Array
        valid_options = options.map(&:first)
        options.each do |k, v|
          message "#{k}: #{v}", :normal
        end
      else
        message "[#{options.join(', ')}]:", :normal
      end
      option = gets.chomp.to_i
    end
    return option
  end
end
