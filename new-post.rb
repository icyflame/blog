# Ruby script to generate the next file for writing today's post in

require 'date'

POSTS_DIR = "_posts"

file_name = "#{Date.today.iso8601}.md"
file_path = "#{POSTS_DIR}/#{file_name}"

puts "CREATED #{file_name}"

filout = File.open file_path, "w"

filout << "---
layout: post
comments: true
title:
categories:
---\n\n"

filout.close()

puts "TEMPLATE inserted in #{file_path}"
