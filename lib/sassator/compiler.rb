require 'fssm'
require 'sass'

module Sassator
  class Compiler
    def initialize
      @monitor = FSSM::Monitor.new
    end

    def watch_folder(folder)
      @monitor.path folder, '*.sass' do
        puts "self is #{self}"
        update do |base, relative|
          puts "self is #{self}"

          puts "compiling #{relative}"
          content = File.read(File.join(base, relative))
          engine = Sass::Engine.new(content, :style => :expanded)
          css =engine.render
          outfile = File.join(base, relative.gsub(/sass$/, "css"))
          File.open(outfile, "w") do |file|
            file.puts css
          end
          puts "css written to #{outfile}"
        end
      end
      puts "added #{folder} to watch list"
    end

    def run
      puts "started monitoring"
      @monitor.run
    end
  end
end