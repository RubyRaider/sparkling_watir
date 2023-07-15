# frozen_string_literal: true

require 'yaml'

desc 'Changes the default platform'
task :platform, [:platform] do |_t, args|
  config = YAML.load_file('./spec/config/caps.yml')
  config['default_platform'] = args.platform
  File.open('./spec/config/caps.yml', 'w') { |file| YAML.dump(config, file) }
end
