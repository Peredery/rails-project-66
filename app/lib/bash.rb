# frozen_string_literal: true

# frozen_string_literals

class Bash
  class << self
    def execute(cmd)
      open3 = ApplicationContainer.resolve('open3')
      stdout, exist_status = open3.popen3(cmd) { |_stdin, stdout, _stderr, wait_thr| [stdout.read, wait_thr.value] }

      yield([stdout, exist_status]) if block_given?

      [stdout, exist_status]
    end
  end
end
