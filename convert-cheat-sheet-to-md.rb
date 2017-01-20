#!/usr/bin/env ruby

unless ARGV.length > 0
  puts "The syntax is convert-cheat-sheet-to-md.rb <input_file_name>"
  exit
end

input_file = File.open(ARGV[0],'r+').readlines

output_file = File.new('OWASP_Web_Application_Testing_Cheat_Sheet.md','w+')


output_file.puts '# OWASP Web Application Testing Cheat Sheet'

input_file.each do |line|
  if line =~ /^==/
    title = line.scan(/(==)([a-zA-Z0-9\-\_ ]+)(==)/)[0][1]
    output_file.puts ""
    output_file.puts "## #{title}"
  end

  if line =~ /^\'\'/
    text = line.scan(/(\'\')([a-zA-Z0-9\-\_ ]+)(\'\')/)[0][1]
    output_file.puts ""
    output_file.puts "#{text}"
  end

  if line =~ /^\*/
    check = line.scan(/(\*)([a-zA-Z0-9\-\_ ]+)/)[0][1]
    if check.empty? or check =~ /^\s*$/
      check = line.scan(/(\*)([ ]+\[\[.+?|)([^|\]]+)(\]\])/)[0][2]
    end

    if (not check.empty?) and (not check =~ /^\s*$/)
      output_file.puts ""
      output_file.puts "- [ ] #{check.strip}"
    end
  end

end

