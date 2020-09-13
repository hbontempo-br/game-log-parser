#! ruby

filename = "/home/henrique/Dev/Personal/quake-log-parser/log_example.log"


file_reader = File.foreach(filename)



file_reader.each do |line|

  if line[' InitGame:']
    puts line
  elsif line[' ShutdownGame:']
    puts line
  elsif line[' ClientUserinfoChanged:']
    puts line
  elsif line[' Kill:']
    puts line
    weapon = line.split.last
    str1_markerstring = ": "
    str2_markerstring = " killed"
    c = line[14.. ][/#{str1_markerstring}(.*?)#{str2_markerstring}/m]
  end
end







puts "Finished"