require "./menu.rb"

menu_items = []

MENU[:sections].each do |section|
  section[:items].each do |items|
    menu_items << items[:name].downcase
  end 
end

order = []

def clear
  system "clear"
end

def space
 puts ""
end


def get_item(menu, order, prompt)
  MENU[:sections].each do |section|
    section[:items].each do |items|
      if items[:name].downcase.include?(prompt)
        item_name = (section[:name].capitalize.to_s + " - " + items[:name].capitalize.to_s)
        order << {item_name => items[:price]}
      end
    end
  end
end

def show_menu(menu)
  MENU[:sections].each do |section|
    puts "*"*30
    puts section[:name].upcase
    puts "*"*30
    section[:items].each do |items|
      puts items[:name].capitalize
      if items[:description]
        puts items[:description].capitalize
      end
      puts "$" + items[:price].to_s
      space
    end
  end
end

puts "How may I help you?",
"Enter (show menu) or (place order).",
space

prompt = gets.chomp.downcase

if prompt.include?("show")

  show_menu(menu)

  puts "Would you like to order?",
  "If yes type (place order)."
  space

  prompt = gets.chomp.downcase

elsif prompt.include?("order")

  clear
  puts "Great! What would you like to order?",
  "Be sure to enter in the full item name. When done enter (done ordering)"
  space

  prompt = gets.chomp.downcase

  until prompt == "done ordering"

    if menu_items.include?(prompt)

      get_item(MENU, order, prompt)

      space
      puts "Great! What else. or (done ordering)"
      space

      prompt = gets.chomp.downcase

    else
      puts "That is not on the menu!",
      "Order something else and be specific!" 
      prompt = gets.chomp.downcase
    end
  end

else
  puts "I'm sorry you don't want to order anything!",
  "Bye!"
end

clear
puts "Would you like the check?",
"If yes enter (get check)."
space

prompt = gets.chomp

if prompt.include?("check") && !order.empty?

  sub_array = []

  order.each do |item|
    item.each do |value, price|
      sub_array << price
    end
  end
  
 subtotal = sub_array.inject(0) {|sum, i|  sum + i }

  space
  clear

  puts "RECEIPT:"
  space
  order.each do |item|
    item.each do |key, value|
    puts "#{key}: $#{("%.2f") % (value)}"
    end
  end

  puts "="*19

  tax = subtotal * 0.06

  total = subtotal + tax

  tip_15 = ("%.2f") % (total * 0.15)

  tip_20 = ("%.2f") % (total * 0.20)

  printf "%20s", "Subtotal: $#{("%.2f") % (subtotal)}\n"
  printf "%20s","6\% tax is: $#{tax}\n"
  printf "%20s","Total: $#{("%.2f") % (total)}\n"
  puts "="*19
  printf "%20s","15\% Tip: $#{tip_15}\n"
  printf "%20s","20\% Tip: $#{tip_20}\n"

elsif prompt.include?("check") && order.empty?
  puts "You must place an order before asking for the check."
else
  puts "Ok, how may I help you?"
  prompt = gets.chomp.downcase
end



