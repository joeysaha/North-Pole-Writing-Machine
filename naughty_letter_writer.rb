require 'erb'

kids_data = File.read('data/kids-data.txt')
naughty_letter = File.read('templates/naughty_letter_template.txt.erb')

kids_data.each_line do |kid|
  kid_data_array = kid.split
  name = kid_data_array[0]
  behavior = kid_data_array[1]
  toys = kid_data_array[2..7]
  randnum = rand(5)
  if toys[randnum] == 'Kaleidoscope'
    if randnum == 0
      randnum += 1
    elsif randnum == toys.length
      randnum -= 1
    else
      randnum += 1
    end
  end
  # negtoys = toys
  # negtoys.delete_at(randnum)
  negtoys = toys.select { |t| t != toys[randnum] }

  next unless behavior == 'naughty'

  crime = kid_data_array[14..-1].join(" ")

  filename = 'letters/naughty/' + name + '.txt'
  letter_text = ERB.new(naughty_letter, nil, '-').result(binding)

  puts "Writing #{filename}."
  File.write(filename, letter_text)

end

puts "Done!!!!!"
