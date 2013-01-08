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

#<Kazz> Do vampires have anuses? Cause that's why I wouldn't let this kid invade a vampire's anus in this RPG, right, I was GMing, and his character was an Anus Shade, with the power to possess and control the anuses of people and animals.. and I figured that vampires don't have anuses.
#<Zaratustra> a vampire's anus is present, but non-working.
#<Zaratustra> like a network card without the appropriate driver.
#<Kazz> Wow. You're the biggest dork on Earth.
#<Sharkey> And you're DMing an rpg with Anus Shades.

# -- end header --
require 'stringio'
require 'test/unit'
require File.dirname(__FILE__) + '/../lib/super_stamper'
