# coding:utf-8 vim:ft=ruby

Pry.config.editor = proc { |file, line| "vim +#{line} #{file}" }

# wrap ANSI codes so Readline knows where the prompt ends
def colour(name, text)
  if Pry.color
    "\001#{Pry::Helpers::Text.send name, '{text}'}\002".sub '{text}', "\002#{text}\001"
  else
    text
  end
end

# pretty prompt
Pry.config.prompt = [
  proc do |object, nest_level, pry|
    prompt  = colour :yellow, Pry.view_clip(object)
    prompt += ":#{nest_level}" if nest_level > 0
    prompt += colour :cyan, ' > '
  end, proc { |object, nest_level, pry| colour :yellow, '> ' }
]

# tell Readline when the window resizes
old_winch = trap 'WINCH' do
  if `stty size` =~ /\A(\d+) (\d+)\n\z/
    Readline.set_screen_size $1.to_i, $2.to_i
  end
  old_winch.call unless old_winch.nil?
end

# use awesome print for output if available
original_print = Pry.config.print
Pry.config.print = proc do |output, value|
  begin
    require 'awesome_print'
    value = value.to_a if defined?(ActiveRecord) && value.is_a?(ActiveRecord::Relation)
    output.puts value.ai
  rescue LoadError => err
    original_print.call(output, value)
  end
end

# startup hooks
org_logger_active_record = nil
org_logger_rails = nil
Pry.hooks.add_hook :before_session, :rails do |output, target, pry|
  # show ActiveRecord SQL queries in the console
  if defined? ActiveRecord
    org_logger_active_record = ActiveRecord::Base.logger
    ActiveRecord::Base.logger = Logger.new STDOUT
  end

  if defined?(Rails) && Rails.env
    # output all other log info such as deprecation warnings to the console
    if Rails.respond_to? :logger=
      org_logger_rails = Rails.logger
      Rails.logger = Logger.new STDOUT
    end

    # load Rails console commands
    if Rails::VERSION::MAJOR >= 3
      require 'rails/console/app'
      require 'rails/console/helpers'
      if Rails.const_defined? :ConsoleMethods
        extend Rails::ConsoleMethods
      end
    else
      require 'console_app'
      require 'console_with_helpers'
    end
  end
end

Pry.hooks.add_hook :after_session, :rails do |output, target, pry|
  ActiveRecord::Base.logger = org_logger_active_record if org_logger_active_record
  Rails.logger = org_logger_rails if org_logger_rails
end
