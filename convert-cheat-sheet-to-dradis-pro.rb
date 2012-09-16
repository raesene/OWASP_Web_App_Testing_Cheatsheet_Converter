#!/usr/bin/env ruby

input_file = File.open('base_cheat_sheet.txt','r+').readlines

output_file = File.new('OWASP_Web_Application_Testing_Cheat_Sheet.xml','w+')


output_file.puts '<methodology>'
output_file.puts '<name>OWASP Web Application Testing Cheat Sheet</name>'
output_file.puts '<sections>'

first_section = true
input_file.each do |line|
  if line =~ /^==/
    title = line.scan(/(==)([a-zA-Z0-9\-\_ ]+)(==)/)[0][1]
    if first_section
      first_section = false
      output_file.puts "<section>\n<name>#{title}</name>\n<tasks>"
    else
      output_file.puts "</tasks>\n</section>\n<section>\n<name>#{title}</name>\n<tasks>"
    end 
  end

  if line =~ /^\*/
    check = line.scan(/(\*)([a-zA-Z0-9\-\_ ]+)/)[0][1]
    output_file.puts "<task>#{check}</task>"
  end

end

output_file.puts "</section>"
output_file.puts "</sections>"
output_file.puts "</methodology>"
