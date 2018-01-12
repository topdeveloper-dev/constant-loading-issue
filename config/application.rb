require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DebugAutoloadedConstants
  def remove_constant(*args)
    return_value = super
    constant_names = autoloaded_constants
    puts "Debug autoloaded constants: #{constant_names}"
    # Count how many times
    entries_per_const = Hash.new(0)
    constant_names.each do |constant_name|
      # Use eval so that we can check for a constant without triggering an auto-load
      constant_defined = eval("defined?(#{constant_name})")
      entries_per_const[constant_name] += 1
      puts "#{constant_name} => #{constant_defined.inspect}"
    end

    if entries_per_const.values.any? { |v| v > 15 }
      raise "Too many duplicate entries (#{entries_per_const})"
    end

    return_value
  end
end

module ActiveSupport::Dependencies
  class << self
    # Uncomment this to debug `remove_constant`
    # prepend DebugAutoloadedConstants
  end
end

module ConstantLoadingIssue
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
