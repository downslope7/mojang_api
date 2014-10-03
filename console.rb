#!/usr/bin/env ruby
# A silly dev console that dumps you into the MojangApi::Profile class to look around.
require 'bundler/setup'
require 'pry'
require 'mojang_api'

p = MojangApi::Profile

pry p
