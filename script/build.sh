#! /bin/bash

CC_RUBY=1.9.3
CC_GEMSET=aasc

# Initialize RVM
source "$HOME/.rvm/scripts/rvm"

# Change gemset
rvm $CC_RUBY@$CC_GEMSET --create

# Is bundler installed?
bundle -v || gem install bundler

# Go get the dependencies
bundle install

bundle exec rake
