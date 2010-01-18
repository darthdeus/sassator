require 'fssm'
require 'sass'

module Sassator
  class Compiler
    def initialize
      @monitor = FSSM::Monitor.new
    end

    #
    # Add pattern to watch list
    #
    def watch_files(pattern)
      recompile_method = self.class.instance_method(:recompile)
      @monitor.path '.', pattern do
        puts "self is #{self}"
        update do |base, relative|
          puts "self is #{self}"

          puts "compiling #{relative}"
          outfile = recompile_method(relative)
          puts "css written to #{outfile}"
        end
      end
      puts "added #{pattern} to watch list"
    end

    def run
      puts "started monitoring"
      @monitor.run
    end

    private

    def render (text)
      engine = Sass::Engine.new(text, :style => :expanded)
      engine.render
    end

    def recompile(relative)
      css = render(File.read(relative))
      outfile = relative.gsub(/sass$/, "css")
      File.open(outfile, "w") do |file|
        file.puts css
      end
      outfile
    end

    def log(string)
      puts string
    end
  end
end