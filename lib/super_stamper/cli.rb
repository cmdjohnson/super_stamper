require 'optparse'

module SuperStamper
  class CLI
    def self.execute(stdout, arguments=[])

      # NOTE: the option -p/--path= is given as an example, and should be replaced in your application.

      options = {
        :filename     => 'header.txt'
      }
      mandatory_options = %w(  )

      parser = OptionParser.new do |opts|
        opts.banner = <<-BANNER.gsub(/^          /,'')
          Easily add a header recursively to multiple files in your project directory.

          Usage: #{File.basename($0)} [options]

          Options are:
        BANNER
        opts.separator ""
        ########################################################################
        opts.on("-f", "--filename PATH", String,
          "Which file to use as header.",
          "Default: header.txt") { |arg| options[:path] = arg }
        ########################################################################
        opts.on("-h", "--help",
          "Show this help message.") { stdout.puts opts; exit }
        ########################################################################
        opts.on("-v", "--version", "Print version (#{SuperStamper::VERSION})") { stdout.puts "#{SuperStamper::VERSION}" }
        opts.parse!(arguments)

        if mandatory_options && mandatory_options.find { |option| options[option.to_sym].nil? }
          stdout.puts opts; exit
        end
      end

      filename = options[:filename]
      
      SuperStamper::Base.stamp_recursively( :header_file_name => filename )
    end
  end
end