require 'rubygems'
require 'puppet-lint/tasks/puppet-lint'
require 'puppetlabs_spec_helper/rake_tasks'
require 'hiera'
require 'rake'
require 'rake/tasklib'
require 'puppet-lint'

PuppetLint.configuration.fail_on_warnings = true
# Disable puppet-lint rules we don't want to enforce right now
PuppetLint.configuration.send('disable_80chars')
PuppetLint.configuration.send('disable_documentation')
# There is a problem with the class_parameter_defaults rule and it will be removed in the future
# See https://github.com/rodjek/puppet-lint/pull/167
PuppetLint.configuration.send('disable_class_parameter_defaults')
PuppetLint.configuration.send('disable_autoloader_layout')
PuppetLint.configuration.ignore_paths = ["spec/**/*.pp", "pkg/**/*.pp", "test/**/*.pp", ".vendor/**/*.pp"]

exclude_paths = [
  "pkg/**/*",
  ".vendor/**/*",
  "spec/**/*",
]
PuppetLint.configuration.ignore_paths = exclude_paths
PuppetSyntax.exclude_paths = exclude_paths


task :default => [:all]

desc "runs all tests"
task :all => [:validate, :spec, :lint]
