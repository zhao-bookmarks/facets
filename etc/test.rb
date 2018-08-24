#!/usr/bin/env ruby

require 'ae'
require 'lemon'
require 'fileutils'

$:.unshift 'lib/core'
$:.unshift 'lib/standard'

# A few File methods utilize this location for testing.
# Ultimately a more robust solution is needed b/c currently
# there is no guarentee that tests are always run from project
# root dir. Perhaps we can do a Dir.chdir to ensure it?
tmp = File.join(File.dirname(__dir__), 'tmp')
FileUtils.mkdir(tmp) unless File.directory?(tmp)

# Default test run.
# Test.run do |r|
#   r.files << 'test'
# end

# Generate SimpleCov coverage report.
Test.run :cov do |r|
  r.files << 'test'
  require 'simplecov'
  SimpleCov.start do
    coverage_dir 'log/coverage'
    add_filter "/test/"
    add_group "Core",       "lib/core"
    add_group "Standard",   "lib/standard"
  end
end
