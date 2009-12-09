require 'fssm'
require 'sass'



def compile(text)
  engine = Sass::Engine.new(text, :style => :expanded)
  engine.render
end

def recompile(base, relative)
  puts "compiling #{relative}"
  css = compile(File.read(relative))
  outfile = relative.gsub(/sass$/, "css")
  File.open(outfile, "w") do |file|
    file.puts css
    puts "css written to #{outfile}"
  end
end

monitor = FSSM::Monitor.new

monitor.path '.', '**/*.sass' do
  create do |base, relative|
    recompile base, relative
  end
  update do |base, relative|
    recompile base, relative
  end
end

begin
  puts "started monitoring"
  monitor.run
rescue Exception => e
  puts e.message
end

puts "stopped monitoring"