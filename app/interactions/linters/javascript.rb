# frozen_string_literal: true

class Linters::Javascript < Linters::Base
  private

  def linter_command
    "npx --no-eslintrc eslint #{repository_path} --format json"
  end

  def parse_errors(linter_output)
    linter_output.flat_map do |file|
      file['messages'].map do |offense|
        {
          file: path_without_workdir(file['filePath']),
          message: offense['message'],
          rule: offense['ruleId'],
          location: "#{offense['line']}:#{offense['column']}"
        }
      end
    end
  end
end
