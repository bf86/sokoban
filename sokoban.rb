game = Proc.new do
  
  def cls
    system 'clear'
  end

  puts "Select a level"
  begin
    system("stty raw -echo")
    level = STDIN.getc
  ensure
    system("stty -raw echo")
  end

  if level == "1"
    rowA ="    #####"
    rowB ="    #   #"
    rowC ="    #o  #"
    rowD ="  ###  o##"
    rowE ="  #  o o #"
    rowF ="### # ## #   ######"
    rowG ="#   # ## #####  ..#"
    rowH ="# o  o          ..#"
    rowI ="##### ### #@##  ..#"
    rowJ ="    #     #########"
    rowK ="    #######"
  end

  if level == "2"
    rowA ="############"
    rowB ="#..  #     ###"
    rowC ="#..  # o  o  #"
    rowD ="#..  #o####  #"
    rowE ="#..    @ ##  #"
    rowF ="#..  # #  o ##"
    rowG ="###### ##o o #"
    rowH ="  # o  o o o #"
    rowI ="  #    #     #"
    rowJ ="  ############"
    rowK =""
  end

  if level == "3"
    rowA ="        ########"
    rowB ="        #     @#"
    rowC ="        # o#o ##"
    rowD ="        # o  o#"
    rowE ="        ##o o #"
    rowF ="######### o # ###"
    rowG ="#....  ## o  o  #"
    rowH ="##...    o  o   #"
    rowI ="#....  ##########"
    rowJ ="########"
    rowK =""
  end

  if level == "q"
    exit
  end

  board = [rowA,rowB,rowC,rowD,rowE,rowF,rowG,rowH,rowI,rowJ,rowK]
  crates = []
  storages = []

  for i in 0..board.length-1
    for ii in 0..board[i].length-1
      if (board[i])[ii] == "@"
        man_x = ii
        man_y = i
      elsif (board[i])[ii] == "o"
        crates.push([ii,i])
      elsif (board[i])[ii] == "."
        storages.push([ii,i])
      end
    end
  end

  print_board = Proc.new do
    placed = 0
    (board[man_y])[man_x] = "@"
    crates.each do |crate|
      (board[crate[1]])[crate[0]] = "o"
    end
    for i in 0..storages.length-1
      storage_x = (storages[i])[0]
      storage_y = (storages[i])[1]
      (board[storage_y])[storage_x] = "."
    end
    for i in 0..storages.length-1
      storage_x = (storages[i])[0]
      storage_y = (storages[i])[1]
      for i in 0..crates.length-1
        crate_x = (crates[i])[0]
        crate_y = (crates[i])[1]
        if storage_x == man_x and storage_y == man_y
          (board[storage_y])[storage_x] = "+"
        elsif storage_x == crate_x and storage_y == crate_y
          (board[storage_y])[storage_x] = "*"
          placed += 1
        end
      end
    end
    puts board
    if placed == crates.length
      puts "Victory!"
      sleep(2)
      exit
    end
  end

  while true
    cls
    print_board.call
  begin
    system("stty raw -echo")
    input = STDIN.getc
  ensure
    system("stty -raw echo")
  end

    if input == "d"
      unless (board[man_y])[man_x+1] == "#" or ((board[man_y])[man_x+1] == ("o" or "*") and (board[man_y])[man_x+2] == ("o" or "*"))
        (board[man_y])[man_x] = " "
        man_x += 1
      end
      for i in 0..crates.length - 1
        if man_y == (crates[i])[1] and man_x == (crates[i])[0]
          unless (board[man_y])[man_x+1] == "#" or (board[man_y])[man_x+1] == "*"
            (crates[i])[0] += 1
          else
            man_x -= 1
          end
        end
      end

    elsif input == "a"
      unless (board[man_y])[man_x-1] == "#" or ((board[man_y])[man_x-1] == ("o" or "*") and (board[man_y])[man_x-2] == ("o" or "*"))
        (board[man_y])[man_x] = " "
        man_x -= 1
      end
      for i in 0..crates.length - 1
        if man_y == (crates[i])[1] and man_x == (crates[i])[0]
          unless (board[man_y])[man_x-1] == "#" or (board[man_y])[man_x-1] == "*"
            (crates[i])[0] -= 1
          else
            man_x += 1
          end
        end
      end

    elsif input == "w"
      unless (board[man_y-1])[man_x] == "#" or ((board[man_y-1])[man_x] == ("o" or "*") and (board[man_y-2])[man_x] == ("o" or "*"))
        (board[man_y])[man_x] = " "
        man_y -= 1
      end
      for i in 0..crates.length - 1
        if man_y == (crates[i])[1] and man_x == (crates[i])[0]
          unless (board[man_y-1])[man_x] == "#" or (board[man_y-1])[man_x] == "*"
            (crates[i])[1] -= 1
          else
            man_y += 1
          end
        end
      end

     elsif input == "s"
      unless (board[man_y+1])[man_x] == "#" or ((board[man_y+1])[man_x] == ("o" or "*") and (board[man_y+2])[man_x] == ("o" or "*"))
        (board[man_y])[man_x] = " "
        man_y += 1
      end
      for i in 0..crates.length - 1
        if man_y == (crates[i])[1] and man_x == (crates[i])[0]
          unless (board[man_y+1])[man_x] == "#" or (board[man_y+1])[man_x] == "*"
            (crates[i])[1] += 1
          else
            man_y -= 1
          end
        end
      end

    elsif input == "q"
      cls
      exit

    elsif input == "r"
      game.call
    end #Movement ifs

  end #Game loop
end #Game

game.call
