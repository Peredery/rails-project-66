# frozen_string_literal: true

class Linters::Base < InteractionsBase
  string :repository_path

  def execute
    linter_result = Bash.execute(linter_command)
    parse_linter_result(linter_result)
  rescue StandardError => e
    errors.add(:base, e.message)
  end

  private

  def linter_command
    raise NotImplementedError, 'Subclasses must implement #linter_command'
  end

  def parse_linter_result(linter_result)
    stdout, exit_status = linter_result
    return { errors: [] } if exit_status.success?

    linter_output = JSON.parse(stdout)
    errors = parse_errors(linter_output)
    { errors: }
  end

  def parse_errors(linter_output)
    raise NotImplementedError, 'Subclasses must implement #parse_errors'
  end

  def path_without_workdir(path)
    path.gsub("#{repository_path}/", '')
  end
end
