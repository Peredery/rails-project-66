# frozen_string_literal: true

class GitUtils
  class << self
    def clone_repo_on_disk(clone_url, path)
      return if File.exist?(path)

      ::Bash.execute("git clone #{clone_url} #{path}")
    end

    def remove_repo_from_disk(path)
      return unless File.exist?(path)

      Bash.execute("rm -rf #{path}")
    end

    def last_commit_id(path)
      Bash.execute("cd #{path} && git rev-parse --short HEAD").first.strip
    end
  end
end
