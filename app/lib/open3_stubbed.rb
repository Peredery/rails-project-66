# frozen_string_literal: true

require 'stringio'

class StubbedProcessStatus
  def success?
    true
  end

  def exitstatus
    0
  end
end

class Open3Stubbed
  def self.capture2(cmd)
    stdout_content = cmd.include?('rubocop') ? '[]' : 'stubbed_stdout'
    stdout = stdout_content
    status = StubbedProcessStatus.new

    [stdout, status]
  end
end
