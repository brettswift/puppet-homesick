# Homesick Puppet Module for Boxen

[![Build Status](https://travis-ci.org/brettswift/puppet-homesick.png?branch=master)](https://travis-ci.org/brettswift/puppet-homesick)

Install [homesick](https://github.com/technicalpickles/homesick)

- dotfile management for OSX

## Usage

### With Hiera
manifests:
```puppet
include homesick
```
hiera:
```yaml
homesick::git_uri: 'git@private_repo.org:brettswift/dotfiles.git'
```
### Without Hiera
```puppet
class { 'homesick': 
	git_uri   => 'git@private_repo.org:brettswift/dotfiles.git'
}
```

## Required Puppet Modules

* `boxen`
* `ruby`

## Development

* Write code.
* `bundle`
* `rake spec`
	* or `guard` (optional) 


To test with guard, and growl: 
*~/.guardrc*
```bash
Guard.options[:notify] = true
Guard.options[:notification] = 'growl'
```