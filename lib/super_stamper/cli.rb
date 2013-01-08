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

#<Goatroper> so i had a checkup at the doctor a couple months ago
#<Goatroper> i waited in the goddamn lobby for like 2 hours
#<Goatroper> i was just starting to doze off when they called me back into one of the exam rooms
#<Goatroper> so i sit on this chair for like 30 more mins, and then fall asleep
#<Goatroper> i wake up and have no idea what time it is or how long i've been waiting
#<Goatroper> so 20 minutes later after I finished reading the Hispanic Business Weekly
#<Goatroper> I start diggin through the drawers in the exam table and his desk drawer
#<Goatroper> i find some hypos and don't touch them, some dressing gowns, and then i get to the drawer marked "OB/GYN"
#<Goatroper> i open it up, take a peeky-peek inside, and what do I see? Speculums and rectal dilators.
#<Goatroper> At this point I'm in his desk rolly-chair
#<Goatroper> with about 40 rubber gloves in my pockets for later use
#<Goatroper> so I grab a speculum in each hand
#<Goatroper> and start making them sing and talk like little ducks
#<Goatroper> i was rooting around for a sharpie and couldn't find one
#<Goatroper> so i put them down and did my glove-trick
#<Goatroper> i stretched a rubber glove over my head and blew it up
#<Goatroper> then i grabbbed the speculums and started spinning around in his chair
#<Goatroper> glove inflated on my head the size of two basketballs
#<Goatroper> speculum in each hand
#<Goatroper> spinning in his office chair
#<Goatroper> i hear footsteps and as i'm extending my legs to slow down, the door opens
#<Goatroper> the doctor is standing there with my chart in his hand
#<kr0nus> omg
#<Goatroper> i stopped spinning and just sat there, looking at him through the thin film of the glove
#<Goatroper> he was like "Corey.....?"
#<Goatroper> I said "Yep."
#<Goatroper> held up the speculums.
#<Goatroper> said, "I got bored."
#<Goatroper> and he was like "That's quite a trick with those gloves. Where did you learn that?"
#<Goatroper> I said "Many doctor's offices in many states."
#<Goatroper> He was like "You want to take some with you?" as I got up
#<Goatroper> I pulled the wad out of my pocket and said "Already did."
#<Goatroper> then I walked out and i heard him laughing like a goddamn maniac as soon as the door was closed
#<Goatroper> then the other day i go in again rofl and he just hands me a brand new unopened box of 100 gloves
#<Goatroper> i was gonna ask for some speculums just to fuck with him but I was afraid he'd give me some

# -- end header --
require 'optparse'

module SuperStamper
  class CLI
    def self.execute(stdout, arguments=[])

      options = {
          :filename => 'header.txt',
          :extension => 'rb',
          :quote => false
      }
      mandatory_options = %w(  )

      parser = OptionParser.new do |opts|
        opts.banner = <<-BANNER.gsub(/^          /, '')
          Easily add a header (such as a copyright notice or license) recursively to multiple files in your project directory.

          Usage: #{File.basename($0)} [options]

          Options are:
        BANNER
        opts.separator ""
        ########################################################################
        opts.on("-e", "--extension PATH", String,
                "Which extension to look for.",
                "Default: rb") { |arg| options[:extension] = arg }
        ########################################################################
        opts.on("-f", "--filename PATH", String,
                "Which file to use as header.",
                "Default: header.txt") { |arg| options[:filename] = arg }
        ########################################################################
        opts.on("-q", "--[no-]quote", "Adds a random quote from the Bash.org QDB. Uses your Internet connection to obtain the quotes from the QDB RSS feed.") do |q|
          options[:quote] = q
        end
        ########################################################################
        opts.on("-h", "--help",
                "Show this help message.") { stdout.puts opts; exit }
        ########################################################################
        opts.on("-v", "--version", "Print version (#{SuperStamper::VERSION})") { stdout.puts "#{SuperStamper::VERSION}"; exit }
        opts.parse!(arguments)

        if mandatory_options && mandatory_options.find { |option| options[option.to_sym].nil? }
          stdout.puts opts; exit
        end
      end

      filename = options[:filename]
      extension = options[:extension]
      quote = options[:quote]

      SuperStamper::Base.stamp_recursively(:header_file_name => filename, :extension => extension, :quote => quote)
    end
  end
end
