# Homesick Puppet Module for Boxen

[![Build Status](https://travis-ci.org/brettswift/puppet-homesick.png?branch=master)](https://travis-ci.org/brettswift/puppet-homesick)

Install [homesick](https://github.com/technicalpickles/homesick)

- dotfile management for OSX

## Usage

```puppet
include homesick
```

## Required Puppet Modules

* `boxen`

## Development

Write code. Run `script/cibuild` to test it. Check the `script`
directory for other useful tools.

To test with guard, and growl: 
*~/.guardrc*
```bash
Guard.options[:notify] = true
Guard.options[:notification] = 'growl'
```