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

#* Quits: crag-- (crag@202.154.72.136) (Dead girls dont say no)
#* Quits: KiM (KiM@134.115.157.196) (going for a walk :p)
#<@ShowDowN> that is sick
#<@ShowDowN> we should ban him next time he comes in
#<@nekro> yeah, who the hell goes for walks

# -- end header --
require File.dirname(__FILE__) + '/test_helper.rb'

require 'fileutils'

class SuperStamperTest < Test::Unit::TestCase
  def setup
    # My files
    @filenames = [ "step1", "step2", "step3", "header1", "header2" ]
    # Copy these files to temp dir
    for file in @filenames
      FileUtils.cp(get_data_filename(file), get_tmp_filename(file))
    end
  end
  
  def test_stamp_single
    step2_str = get_tmp_file('step2').read
    step3_str = get_tmp_file('step3').read
    
    SuperStamper::Base.stamp_single( :filename => get_tmp_filename('step1'), :header_file_name => get_tmp_filename('header1') )
    assert_equal step2_str, get_tmp_file('step1').read
    
    SuperStamper::Base.stamp_single( :filename => get_tmp_filename('step2'), :header_file_name => get_tmp_filename('header2') )
    assert_equal step3_str, get_tmp_file('step2').read
  end
  
  protected
  
  def get_data_filename name
    File.join("test", "data", "#{name}.txt")
  end
  
  def get_tmp_file name
    File.new(get_tmp_filename(name))
  end
  
  def get_tmp_filename name
    File.join("test", "tmp", "#{name}.txt")
  end
end

