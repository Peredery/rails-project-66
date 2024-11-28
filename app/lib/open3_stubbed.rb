# frozen_string_literal: true

class Open3Stubbed
  def self.popen3(_cmd)
    stdout = StringIO.new('stubbed stdout')

    exit_status = Object.new
    def exit_status.exitstatus
      0
    end

    wait_thr = Object.new
    def wait_thr.value
      exit_status
    end

    yield(nil, stdout, nil, wait_thr)
    [stdout.string, exit_status]
  end
end
