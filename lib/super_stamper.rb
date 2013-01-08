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

#<by> Is there anyway I can tell the world I'm an idiot?
#<Seven7> Of course, just type your name, where you live and your confession
#<by> Kk
#<by> I am Mark Duval of Belgium, and I am an idiot
#<by> ?
#<by> Now what?
#<Seven7> Don't worry. It's done

# -- end header --

$:.unshift(File.dirname(__FILE__)) unless $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

# try to include stuff for getting those quotes
begin
  require 'simple-rss'
  require 'nokogiri'
  require 'open-uri'
rescue
end

module SuperStamper
  # a version constant
  VERSION = '0.0.5'
  # a class
  class Base
    BEGIN_HEADER = "# -- begin header --"
    END_HEADER = "# -- end header --"
    DEFAULT_HEADER_FILE_NAME = "header.txt"
    NEWLINE = "\n"
    QUOTEFEED="http://feeds.sydv.net/top200-bash-quotes"

    def self.stamp_recursively(options = {})
      #puts options.inspect
      extension = options[:extension] || "rb"

      count = 0

      ##########################################################
      # Optional: add quote from IRC.
      # First make an inventory of all the quotes.
      ##########################################################
      quote_database = nil
      # Add quote from IRC
      if defined?(SimpleRSS) && defined?(Nokogiri) && options[:quote]
        puts "super_stamper: You ordered some quotes. Let me see if I can arrange that for you ..."
        # +_+ #
        quotefeed = options[:quotefeed] || QUOTEFEED
        # +_+ #
        begin
          puts "super_stamper: Getting quotes from #{quotefeed} ..."
          # +_+ #
          rss = SimpleRSS.parse open(quotefeed)
          # get all descriptions.
          # needs double escaping.
          quote_database = rss.entries.collect { |e| "##{CGI.unescapeHTML(CGI.unescapeHTML(e[:description])).gsub(/\<br\s?\/\>/, "\n#").gsub("&nbsp;", "")}" }
          puts "super_stamper: Successfully gathed quote database. Putting them into your source files like a smooth operator ..."
        rescue => e
          puts "super_stamper: Sorry, couldn't add quotes to your files."
          puts "super_stamper: Error was: #{e}"
          puts "super_stamper: Proceeding with normal operation."
        end
      end
      ##########################################################

      Dir["**/*.#{extension}"].each do |f|
        ########################################################
        le_stamp_options = {:filename => f, :header_file_name => options[:header_file_name]}
        ########################################################
        # Quote?
        ########################################################
        le_stamp_options[:quote] = quote_database.sample unless quote_database.nil?
        ########################################################
        stamp_single le_stamp_options
        ########################################################
        count += 1
        ########################################################
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
        # quote is optional.
        quote = options[:quote] || ""
        quotestring = ""
        quotestring = "#{NEWLINE}#{quote}#{NEWLINE}#{NEWLINE}" unless quote.eql?("")
        # and now .. do this.
        contents_array = [BEGIN_HEADER, NEWLINE, header, quotestring, END_HEADER, NEWLINE]
        # behavior of to_s changed from Ruby 1.8.7 to 1.9.3,
        # used to be [ "foo", "bar" ].to_s # => "foobar" <--- 1.8.7
        # now it's => "[\"foo\", \"bar\"]" # 1.9.3
        #contents_str = contents_array.to_s
        contents_str = contents_array.join
        # Remove the header that was already in place, if any.
        str.gsub!(/#{BEGIN_HEADER}.*#{END_HEADER}#{NEWLINE}/m, '')
        # concat it
        #contents = contents_str + str
        contents = "#{contents_str}#{str}"
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
