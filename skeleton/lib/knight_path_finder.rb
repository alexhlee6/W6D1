require_relative "00_tree_node.rb"

class KnightPathFinder 
    MOVES = [ 
        [2,1], [2,-1], 
        [-2,1], [-2,-1],
        [1,2], [1,-2],
        [-1,2], [-1,-2]
    ]


    def self.valid_moves(pos) 
        possible_moves = [] 

        MOVES.each do |subarr|       
            x = subarr[0] + pos[0]
            y = subarr[1] + pos[1] 
            if (0..7).include?(x) && (0..7).include?(y) 
                possible_moves << [x, y]
            end 
        end 
        possible_moves
    end 


    def initialize(starting_pos)
        @root_node = PolyTreeNode.new(starting_pos)
        @considered_positions = [starting_pos] 
    end 


    def new_move_positions(pos) 
        possible = KnightPathFinder.valid_moves(pos)
        
        possible.select! { |position| !@considered_positions.include?(position) }
        possible.each { |position| @considered_positions << position } 
        possible
    end 


    def build_move_tree
        queue = [ ] 
        queue << @root_node 

        moves = [] 

        until queue.empty?
            current_node = queue.shift

            possible_moves = new_move_positions(current_node.value) 
            possible_moves.each do |move| 
                child = PolyTreeNode.new(move) 
                queue << child 

                moves << child.value 

                current_node.add_child(child)
            end 
        end 
        # print moves
    end 

end 

# kpf = KnightPathFinder.new([0, 0])
# kpf.build_move_tree 