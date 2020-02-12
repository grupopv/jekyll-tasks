# frozen_string_literal: true

require_relative 'lib/jekyll/tasks/version'

Gem::Specification.new do |spec|
  spec.name          = 'jekyll-tasks'
  spec.version       = Jekyll::Tasks::VERSION
  spec.authors       = ['Edgar Tinajero']
  spec.email         = ['24572406+cetinajero@users.noreply.github.com']

  spec.summary       = 'A set of tasks to help you on your Jekyll sites.'
  spec.homepage      = 'https://github.com/grupopv/jekyll-tasks/'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/grupopv/jekyll-tasks/'
  spec.metadata['changelog_uri'] = 'https://github.com/grupopv/jekyll-tasks/blob/master/CHANGELOG.md'

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Specify which files should be added to the gem when it is released.
  # `git ls-files -z` loads the files that have been added into git.
  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end
end
