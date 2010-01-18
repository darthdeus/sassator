require 'rubygems'
require 'sassator/compiler'


compiler = Sassator::Compiler.new
compiler.watch_files('*.sass')
compiler.run