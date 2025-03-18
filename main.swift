//
//  main.swift
//  Tic Tac Toe
//
//  Created by Laudeman, Luke D on 2/9/25.
//



import Foundation

//explanation of how to play:
// Explanation of the coordinate system
func instructions() {
    print("""
    When you get asked where you want to play your piece, use a coordinate system like below:
    
    Where do you want to place your piece?
    ANSWER: [row #],[col #]
    
    EXAMPLE ANSWER AND BOARD: 3, 3
    
            col 1:  col 2:  col 3: 
    row 1: [       ,       ,       ]
    row 2: [       ,       ,       ]
    row 3: [       ,       ,       ]
    """)
}

//loop to make sure player understands
var understand = false
while !understand {
    instructions() //calls the function instructions which prints the instructions
    print("\n Do you understand how to play? (y/n)")
    let response = readLine() //readLine reads the users input into an optional string
    if response == "y" || response == "Y" {
        understand = true
    } else {
        print("Okay, let's go over it again")
    }
}

print("\n Great! Let's start the game!!!")

//^the above loop is just a simple loop I created to print the instructions of the tic tac toe game (which can be appended to later), but this ensures the user knows how to play and such. I'll probably add better and more detailed instructions later down the line, but its more about the coordinate system than anything.


print("\n")
//Could do a function here to see what player wants to be X and O


//I'm using a struct to keep track of the board 2d array and then to store functions that heavily involve the board array like printing the board or adding a game piece
struct Board {
    //NOTES:
    //in classes and structs, we declare variables and instance properties without values, EX: "var name: String", unless you add a default value, EX: "var name: String = "john" "
    //the init (initializer) is responsible for assigning values to those properties after they're created (when an instance of this class is created)
    
    private var board: [[String]] //creates a 2d array of strings (our board)
    
    
    init() {
        //NOTES:
        //using self tells swift to assign the init parameter value to the instance property of the object being created
        //no need for self if the paramter name in init and the property name you declared in the beginning of the class are different
        //similar to "this" in C++

        self.board = Array(repeating: Array(repeating: " ", count: 3), count: 3)
        //^this will intialize the board var which is a 2d array of strings to a 3 by 3 array with blank spaces in each cell
        
    }
    
    //function to print the tic tac toe board by row so it looks like a 3x3 and has a | in between each space
    func print_board() {
        print("\n    1    2    3")
        for (col, row) in board.enumerated() { //enumerate is used to iterate and keep track of the current iteration
            print("\(col+1) | \(row[0]) | \(row[1]) | \(row[2]) |")
            //instead of just printing each array line out, this print line formats it better so it looks like " X | O | X ". It also adds one to the column number, starting at 1, and adds it to the side to look better for the user
        }
    }
    
    
    mutating func place_piece(row: Int, col: Int, piece: String) -> Bool {
        //the parameters row and col allow for an inputted number value which are the place the user wants to place their piece on the board. the piece is the symbol of the player which is important to know which place to piece
        
        //also did not realize we need to include the mutating word because we are trying to change the values of the Board item which is contained within a struct so aparently we need this keyword to make it work.
        
        //we first need to make sure the space the user wants to put their piece is empty because if something is already there, we cant put a piece there
        if board[row][col] == " " {
            //the spot is empty so we place a piece in that spot:
            board[row][col] = piece
            return true //the piece was successfully placed so we are good to go
        } else {
            //this option means there is already a piece in the spot so we have to return false -- that the operation didn't work
            return false
        }
        
    } //end of place_piece function
    
    
    //we need a function to store our winning combinations in and check if the user has won:
    func check_win() -> String? {
        
        let winCombos = [
            //these are specific combos of X's and O's signaling a win
            //let also makes it constant because it shouldn't change
            //these combos are all possible combinations that could be a win
            //each array inside of this array represents three combos that a player must have to win
            //its row, col btw
            [(0,0), (0,1), (0, 2)], //top row all the way across
            [(1,0), (1,1), (1, 2)], //2nd row all the way across
            [(2,0), (2,1), (2, 2)], //3rd row all the way across
            //then I can just copy this and change it a bit for the columns:
            [(0,0), (1,0), (2,0)], //left most column all the way down
            [(0,1), (1,1), (2,1)], //middle column down
            [(0,2), (1,2), (2,2)], //right most column down
            //now diagonal combos:
            [(0,0), (1,1), (2,2)], //Goes like this: \
            [(2,0), (1,1), (0,2)] //Goes like this: /
        ]
        
        for combo in winCombos {
            //loop to go through the winning combos and then we can match the arrays to what is on the board
            
            //combo are individual arrays from the winCombos array so each 3 coordinate pattern is one combo array
            let (r1, c1) = combo[0]
            let (r2, c2) = combo[1]
            let (r3, c3) = combo[2]
            //if a combo matches to one of the winning conditions, then it grabs the pattern and checks it against the array
            
            
            //now that we have the three row/col positions, we need to check if they are the same symbol because that'd be a winner. If they're different symbols then not. Also gotta make sure they aren't blank
            if board[r1][c1] != " " &&
                       board[r1][c1] == board[r2][c2] &&
                       board[r2][c2] == board[r3][c3] {
                //this above operation goes through the three boxes in question and compares the pieces in each. If they're the same, then the player has won so we need to return any of these symbols:
                return board[r3][c3]
            }
        }
        
        return nil //realized after trying it we need this return statement in case we get to this point and no one wins
    }
    
}


class TicTacToe {
    var board: Board //creates a variable "board" of type Board, the struct we made earlier
    var currPlayer: String //variable to keep track of the player
    init() {
        self.board = Board()
        self.currPlayer = "X"
    }
    
    
    
    
    func startGame() {
        //I think this is where I'll finish it up and play the game. There isn't really a main function persay but i think just calling this and having the instructions here to play in a while loop or something would be good
        while true { //keep playing until I make it false I guess
            board.print_board() //prints out the current board
            
            //now we need to ask what move they want to make:
            print("Player \(currPlayer), what move do you want to make? Enter as [row, col]")
            
            //get user input:
            let userInput = readLine()
            //userInput is an optional string so we need to unwrap it here:
            if let userInput = userInput, userInput.contains(",") {
                
                //now we made sure the input is fine and has what we need so I need to somehow split it up.
                //because right now its number, number which wont work i dont think
                //I looked it up a bit and I think .split will allow us to seperate the userInput into an array
                var split = userInput.split(separator: ",")
                
                //now the values are still strings so we need to convert them into integers and we can seperat them into their own variable at the same time for [row, col]
                var row = Int(split[0])! - 1
                var col = Int(split[1])! - 1
                //subtracting the 1 puts the users input in a way so the array can understand it
                
                //now we need to place the piece:
                if board.place_piece(row: row, col: col, piece: currPlayer) {
                    
                    if let winner = board.check_win() {
                        board.print_board()
                        print("\nPlayer \(winner) wins!")
                        break
                    }
                    
                    //switches the current player after each turn
                    if currPlayer == "X" {
                        currPlayer = "O"
                    } else {
                        currPlayer = "X"
                    }
                }else {
                    print("The spot is already taken. Please choose another one.")
                }
            }
        }
    }
}

let game = TicTacToe()
game.startGame()
