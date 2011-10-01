require 'optparse'

module SuperStamper
  class CLI
    def self.execute(stdout, arguments=[])

      options = {
        :filename     => 'header.txt',
        :extension    => 'rb'
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
        opts.on("-e", "--extension PATH", String,
          "Which extension to look for.",
          "Default: rb") { |arg| options[:extension] = arg }
        ########################################################################
        opts.on("-f", "--filename PATH", String,
          "Which file to use as header.",
          "Default: header.txt") { |arg| options[:filename] = arg }
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
      
      SuperStamper::Base.stamp_recursively( :header_file_name => filename, :extension => extension )
    end
  end
end