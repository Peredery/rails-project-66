# frozen_string_literal: true

class Linters::Ruby < Linters::Base
  private

  def linter_command
    "bundle exec rubocop --format json #{repository_path}"
  end

  def parse_errors(linter_output)
    linter_output['files'].flat_map do |file|
      file['offenses'].map do |offense|
        {
          file: path_without_workdir(file['path']),
          message: offense['message'],
          rule: offense['cop_name'],
          location: "#{offense['location']['line']}:#{offense['location']['column']}"
        }
      end
    end
  end
end
