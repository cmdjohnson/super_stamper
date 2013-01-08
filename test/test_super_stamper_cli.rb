# -*- encoding : utf-8 -*-
# -- begin header --
###############################################################################
# super_stamper, a nifty tool that puts headers in all your source files.
# It does exactly what you see here: a header.txt file is pasted into every .rb file.
# Also, some random quotes can be added just for kicks.
#
# Protip: also install the magic_encoding gem alongside to use it like this:
# $ super_stamper -q && magic_encoding
#
# (c) 2012 Commander Johnson
# Licensed under the MIT license
###############################################################################

#<UKDJ|Planet> I swear to god
#<UKDJ|Planet> I've just heard a duck tell a joke
#<Jock> o...k
#<UKDJ|Planet> there was as group of ducks on a pond near where i live
#<UKDJ|Planet> one of the ducks was quacking away looking straight at a group of like 10 ducks
#<UKDJ|Planet> then he stopped and all the other ducks went mental
#<UKDJ|Planet> it looked just like duck stand-up comedy

# -- end header --
require File.join(File.dirname(__FILE__), "test_helper.rb")
require 'super_stamper/cli'

class TestSuperStamperCli < Test::Unit::TestCase
  def setup
    SuperStamper::CLI.execute(@stdout_io = StringIO.new, [])
    @stdout_io.rewind
    @stdout = @stdout_io.read
  end
  
#  def test_print_default_output
#    assert_match(/To update this executable/, @stdout)
#  end
end
