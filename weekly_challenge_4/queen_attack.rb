class Queens 
    attr_accessor :white, :black, :board
    def initialize(white: [0,3], black:[7,3])
      raise ArgumentError if white == black 
      @white = white
      @black = black
      @board = []
      (0..7).each do
         @board << ['_','_','_','_','_','_','_','_']  
      end
    end
 
    def to_s
        self.board[white[0]][white[1]] = 'W'
        self.board[black[0]][black[1]] = 'B'
        string = ''
        count = 0 
        board.each do |item|
            string += item.join(' ') 
            string += "\n" if count < 7
            count += 1
        end
        string
    end
    
   def attack?  
      true if white[0] == black[0] || white[1] == black[1] || (white[1] - black[1]) / (white[0] - black[0]) == 1 ||  (white[1] - black[1]) / (white[0] - black[0]) == -1
   end
# If slop is the same, then on the same diagnol
end
