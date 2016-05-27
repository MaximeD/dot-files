# === EDITOR ===
Pry.editor = 'vim'

# === CUSTOM PROMPT ===
# wrap ANSI codes so Readline knows where the prompt ends
def colour(name, text)
  if Pry.color
    "\001#{Pry::Helpers::Text.send name, '{text}'}\002".sub '{text}', "\002#{text}\001"
  else
    text
  end
end

def base_prompt(obj, nest_level, eol_char)
  ruby_version = colour(:yellow, RUBY_VERSION)
  obj = colour(:cyan, obj)
  level = colour(:green, nest_level)
  eol = colour(:purple, eol_char)

  ruby_version + ' ' + obj + ':' + level + ' ' + eol + ' '
end

# This prompt shows the ruby version (useful for rbenv)
Pry.prompt = [
  proc { |obj, nest_level, _| base_prompt(obj, nest_level, '>') },
  proc { |obj, nest_level, _| base_prompt(obj, nest_level, '*') }
]

# === Listing config ===
# Better colors - by default the headings for methods are too
# similar to method name colors leading to a "soup"
# These colors are optimized for use with Solarized scheme
# for your terminal
Pry.config.ls.separator = "\n" # new lines between methods
Pry.config.ls.heading_color = :magenta
Pry.config.ls.public_method_color = :green
Pry.config.ls.protected_method_color = :yellow
Pry.config.ls.private_method_color = :bright_black

# == PLUGINS ===
# awesome_print gem: great syntax colorized printing
# look at ~/.aprc for more settings for awesome_print
begin
  require 'awesome_print'

  AwesomePrint.pry!

  # Enable awesome_print for all pry output, and paging
  Pry.config.print = proc do |output, value|
    Pry::Helpers::BaseHelpers.stagger_output("=> #{value.ai}", output)
  end

  # If you want awesome_print without automatic pagination, use the line below
  # Pry.config.print = proc { |output, value| output.puts value.ai }
rescue LoadError
  puts 'gem install awesome_print  # <-- highly recommended'
end

# === CONVENIENCE METHODS ===
# Stolen from https://gist.github.com/807492
# Use Array.toy or Hash.toy to get an array or hash to play with
class Array
  def self.toy(n = 10, &block)
    block_given? ? Array.new(n, &block) : Array.new(n) { |i| i + 1 }
  end
end

class Hash
  def self.toy(n = 10)
    Hash[Array.toy(n).zip(Array.toy(n) { |c| (96 + (c + 1)).chr })]
  end
end

# runs benchmark comparing an array of methods
def benchmark(methods)
  Benchmark.ips do |x|
    x.config(time: 5, warmup: 2)

    methods.each do |name, method|
      x.report(name) { method }
    end

    x.compare!
  end
end
