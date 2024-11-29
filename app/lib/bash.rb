# frozen_string_literal: true

class Bash
  class << self
    def execute(cmd)
      open3 = ApplicationContainer.resolve('open3')
      stdout, exit_status = open3.capture2(cmd)

      yield(stdout) if block_given?

      [stdout, exit_status]
    end
  end
end
