# Ruby script to generate the next file for writing today's post in

require 'date'

FIRST_DAY = Date.parse "18th February, 2017"
POSTS_DIR = "_posts"

def get_post_name date
  "#{date.iso8601}-day-#{(date - FIRST_DAY).to_i + 1}.md"
end

file_name = get_post_name (Date.today - 1)
num_days = (Date.today - 1 - FIRST_DAY).to_i + 1
if File.exists? "#{POSTS_DIR}/#{file_name}"
  file_name = get_post_name (Date.today)
  num_days += 1
end

file_path = "#{POSTS_DIR}/#{file_name}"

puts "CREATED #{file_name}"

filout = File.open file_path, "w"

filout << "---
layout: post
comments: true
title: Day #{num_days} - 
categories: 100daysofwriting
---\n\n"

filout.close()

puts "TEMPLATE inserted in #{file_path}"
