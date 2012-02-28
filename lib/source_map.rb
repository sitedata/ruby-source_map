require File.expand_path("../source_map/vlq.rb", __FILE__)
require File.expand_path("../source_map/generator.rb", __FILE__)

class SourceMap
  include SourceMap::Generator

  # Create a new blank SourceMap
  #
  # Options may include:
  #
  # :file => String         # See {#file}
  # :source_root => String  # See {#source_root}
  # :generated_output => IO # See {#generated_output}
  # :version => 3           # Which version of SourceMap to use (only 3 is allowed)
  #
  def initialize(opts={})
    unless (remain = opts.keys - [:generated_output, :file, :source_root, :version]).empty?
      raise ArgumentError, "Unsupported options to SourceMap.new: #{remain.inspect}"
    end
    self.generated_output = opts[:generated_output]
    self.file = opts[:file] || ''
    self.source_root = opts[:source_root] || ''
    self.version = opts[:version] || 3
    raise "version #{opts[:version]} not supported" if version != 3
  end

  # The name of the file containing the code that this SourceMap describes.
  # (default "")
  attr_accessor :file

  # The URL/directory that contains the original source files.
  #
  # This is prefixed to the entries in ['sources']
  # (default "")
  attr_accessor :source_root

  # The version of the SourceMap spec we're using.
  # (default 3)
  attr_accessor :version

  # The list of sources (used during parsing/generating)
  # These are relative to the source_root.
  def sources
    @sources ||= []
  end

  # A list of names (used during parsing/generating)
  def names
    @names ||= []
  end

  # A list of mapping objects.
  def mappings
    @mappings ||= []
  end
end
