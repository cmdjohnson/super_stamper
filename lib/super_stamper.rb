# -*- encoding : utf-8 -*-

$:.unshift(File.dirname(__FILE__)) unless
$:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module SuperStamper
  # a version constant
  VERSION = '0.0.2'
  # a class
  class Base
    BEGIN_HEADER = "# -- begin header --"
    END_HEADER = "# -- end header --"
    DEFAULT_HEADER_FILE_NAME = "header.txt"
    NEWLINE = "\n"
  
    def self.stamp_recursively(options = {})
      extension = options[:extension] || "rb"
    
      count = 0
    
      Dir["**/*.#{extension}"].each do |f|
        le_stamp_options = { :filename => f, :header_file_name => options[:header_file_name] }
        stamp_single le_stamp_options
        count += 1
      end
    
      # Informative!
      puts "super_stamper: I inserted a header into #{count} files with extension .#{extension} (recursively)."
    
      count
    end

    def self.stamp_single(options = {})
      ret = nil
    
      file = nil
      header = nil
    
      filename = options[:filename]
      header_file_name = options[:header_file_name] || "header.txt"
    
      raise "I need a filename" if filename.nil?
      raise "Please provide a valid filename (-f) or create a header.txt in your working directory." unless File.exists?(header_file_name)
    
      file = File.new(filename)
      header = File.new(header_file_name).read
    
      unless file.nil? || header.nil?
        str = file.read
        # Let's remove the magic_encoding at the start, if any.
        str.gsub!(/^# -\*-.+-\*-(\r)?#{NEWLINE}/, '')
        # and now .. do this.
        contents_array = [ BEGIN_HEADER, NEWLINE, header, NEWLINE, END_HEADER, NEWLINE ]
        contents_str = contents_array.to_s
        # Remove the header that was already in place, if any.
        str.gsub!(/#{BEGIN_HEADER}.*#{END_HEADER}#{NEWLINE}/m, '')
        # concat it
        contents = contents_str + str
        # Re-open file and write to it
        file.close
        file = File.new(filename, 'w')
        # write
        file.write(contents)
        # close again
        file.close
        # Return it
        ret = file
      end
    
      ret
    end
  end
end