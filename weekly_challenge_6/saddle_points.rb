require 'pry'
class Matrix
    attr_accessor :rows, :columns
    def initialize(string)
        @rows = []
        @columns = []
        #for rows
        temp_array = string.split("\n")
        temp_array.map! do |x|
           x.split(' ') 
        end
        temp_array.each do |x|
            item_arr = x.map do |y|
               y.to_i
            end
           self.rows << item_arr 
        end
        #for columns
        (0...rows[0].size).each do |x|
            temp = []
            rows.each do |row|
                temp << row[x]
            end
            self.columns << temp
        end
    end
    
    def saddle_points
        saddle_coordinate = []
       row_index = 0
       rows.each do |x|
         column_index = 0 
         x.each do |val|
             saddle_coordinate << [row_index, column_index ] if rows[row_index].max == val && columns[column_index].min == val
             column_index += 1
         end
         row_index += 1
       end
       saddle_coordinate
    end
end
