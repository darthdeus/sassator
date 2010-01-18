require 'rubygems'
require 'sassator/compiler'

compiler = Sassator::Compiler.new
ARGV.each { |arg| compiler.watch_folder(arg) }
compiler.run