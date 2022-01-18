def list(parameter_gifts)
  parameter_gifts.each_with_index do |gift, index|
    # if gift[:status] == true
    #   box = "[X]"
    # else
    #   box = "[ ]"
    # end

    gift[:status] ? box = "[X]" : box = "[ ]"

    puts "#{index + 1}. #{box} #{gift[:name].capitalize}"
  end
end
