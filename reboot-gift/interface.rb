require_relative 'christmas_list'
require 'nokogiri'
# 1. Greet the user
puts "Welcome to your Christmas list!"

# gifts = %w(macbook headset furniture)
gifts = [
  {name: "macbook", status: false},
  {name: "headset", status: false},
  {name: "furniture", status: true}
]
# LOOP STARTS HERE
#   => set a condition to enter/break the loop
user_choice = ""

# while user_choice != "quit"
until user_choice == "quit"
  # 1. Ask the user to choose an action
  puts "\nWhich action? [ list | idea | add | delete | mark | quit ]"
  # 2. Retrieve user input & store it in a variable
  user_choice = gets.chomp.downcase

  # 3. Conditional statement based on user choice
  case user_choice
  #   3.1 When 'list'
  when "list"
    # Display all gifts
    #   (each_with_index)
    # CALL METHOD
    list(gifts)
  #   3.2 When 'add'
  when "add"
    # Ask the user which item 
    puts "Enter the name:"
    # Store input in a variable
    gift = gets.chomp
    # Push gift to gifts Array
    # gifts << gift
    # p gifts 
    # p gift
    gift_add = {name: gift, status: false}
    # p gift_add
    gifts << gift_add
    # p gifts
    # gifts.push(gift_add)
  #   3.3 When 'delete'
  when "delete"
    # Display the list of gifts
    # CALL METHOD
    list(gifts)
    # Ask the user which item
    puts "Which item (type index)?"
    # Store it in a variable
    index = gets.chomp.to_i - 1
    # Delete item from Array
    gifts.delete_at(index)
  #   3.4 When 'mark'
  when "mark"
    # Display the list of gifts
    list(gifts)
    # Ask the user which one
    puts "Which item (type index)?"
    # Store input in a variable
    index = gets.chomp.to_i - 1
    # Toggle the status
    # p gifts[index][:status]
    # if gifts[index][:status] == true
    #   gifts[index][:status] = false
    # elsif gifts[index][:status] == false
    #   gifts[index][:status] = true
    # end
    # if value_is_true
    #   set_it_to_false
    # else (value_is_false)
    #   set_it_to_true
    # end
    # true                  =  false
    # false                 =  true
    gifts[index][:status] = !gifts[index][:status]
    # p gifts[index][:status]
    # hash[:key] = true 
    # (ref. update element inside Hash)
  #   3.5 When 'quit'
  when "idea"
    etsy_gifts = []

    filepath = "./results.html"

    html_content = File.open(filepath)
    
    doc = Nokogiri::HTML(html_content)

    doc.search('.v2-listing-card__title').each do |match|
        etsy_gifts << {name: match.text.strip, status: false}
    end

    puts "What are you looking for on Etsy?"
    user_response = gets.chomp

    puts "Here are Etsy results for #{user_response}:"
    list(etsy_gifts)

    puts "Pick one to add to your list (give the number)"
    etsy_choice = gets.chomp.to_i

    gifts << etsy_gifts[etsy_choice - 1]

  when "quit"
    puts ""
  else 
    puts "Wrong choice, try again!"
  end
end
# 4. Say goodbye to user
puts "Goodbye!" 

# v2-listing-card__title