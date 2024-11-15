# frozen_string_literal: true

class Repository::PerformLint < InteractionsBase
  object :check, class: Repository::Check
  validate :check_can_start

  def execute
    check.start!
    @repository = check.repository
    GitUtils.clone_repo_on_disk(check.repository.clone_url, repository_path)
    check.commit_id = GitUtils.last_commit_id(repository_path)

    linter_service = Object.const_get("Linters::#{check.repository.language.capitalize}").run(repository_path:)

    if linter_service.valid?
      Repository::Check.transaction do
        check.result = linter_service.result[:errors]
        check.complete!
        check.passed = check.result.empty?
        check.save
      end
    else
      errors.merge!(linter_service.errors)
    end
  rescue StandardError => e
    errors.add(:base, e.message)
  ensure
    GitUtils.remove_repo_from_disk(repository_path)
  end

  def repository_path
    @repository_path ||= File.join('tmp/', @repository.full_name)
  end

  private

  def check_can_start
    errors.add(:check, t('linter.cannot_start')) unless check.may_start?
  end
end
