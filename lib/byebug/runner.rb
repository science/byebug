require 'slop'
require 'ostruct'
require 'English'
require 'byebug/core'
require 'byebug/options'

module Byebug
  #
  # Responsible for starting the debugger when started from the command line.
  #
  class Runner
    BYEBUG_SCRIPT = File.expand_path('../../../../bin/byebug')
    IGNORED_FILES << BYEBUG_SCRIPT

    #
    # Debug a script only if syntax checks okay.
    #
    def debug_program(options)
      output = `ruby -c "#{Byebug.debugged_program}" 2>&1`
      if $CHILD_STATUS.exitstatus != 0
        Byebug.puts output
        exit $CHILD_STATUS.exitstatus
      end

      status = Byebug.debug_load(Byebug.debugged_program, options[:stop])
      Byebug.puts "#{status}\n#{status.backtrace}" if status
    end

    #
    # Starts byebug to debug a program
    #
    def run
      opts = Byebug::Options.parse

      return Byebug.puts("\n  Running byebug #{VERSION}\n") if opts[:version]
      return Byebug.puts("#{opts.help}\n") if opts[:help]

      if opts[:remote]
        port, host = opts[:remote].pop.to_i, opts[:remote].pop || 'localhost'
        Byebug.puts "Connecting to byebug server #{host}:#{port}..."
        Byebug.start_client(host, port)
        return
      end

      Byebug.set_debugged_program

      # Set up trace hook for byebug
      Byebug.start

      # Load initrc script (e.g. .byebugrc)
      Byebug.run_init_script if opts[:rc]

      # Post Mortem mode status
      Byebug::Setting[:post_mortem] = opts[:'post-mortem']

      # Line Tracing Status
      Byebug::Setting[:linetrace] = opts[:trace]

      loop do
        debug_program(opts)

        break if opts[:quit]

        processor = Byebug::ControlCommandProcessor.new
        processor.process_commands
      end
    end
  end
end
