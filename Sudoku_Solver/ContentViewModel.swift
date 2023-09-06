//
//  ContentViewModel.swift
//  Sudoku_Solver
//
//  Created by Sarthak Agrawal on 31/08/23.
//

import Foundation

class ContentViewModel:ObservableObject{
    
    let sudoku1: Sudoku = [
        [5,3,0, 0,7,0, 0,0,2],
        [6,0,0, 1,9,5, 0,0,0],
        [0,9,8, 0,0,0, 0,6,0],
        
        [8,0,0, 0,6,0, 0,0,3],
        [4,0,0, 8,0,3, 0,0,1],
        [7,0,0, 0,2,0, 0,0,6],
        
        [0,6,0, 0,0,0, 2,8,0],
        [0,0,0, 4,1,9, 0,0,5],
        [0,0,0, 0,8,0, 0,7,0],
    ]
    
    let sudoku2: Sudoku = [
    [9,0,0, 0,0,0, 6,0,0],
    [0,8,0, 0,0,0, 0,5,0],
    [0,0,7, 0,0,0, 0,0,4],
    
    [3,0,0, 6,0,0, 9,0,0],
    [0,2,0, 0,5,0, 0,8,0],
    [0,0,1, 0,0,4, 0,0,7],
    
    [6,0,0, 9,0,0, 3,0,0],
    [0,5,0, 0,8,0, 0,2,0],
    [0,0,4, 0,0,7, 0,0,1]
    ]
    
    
    func solve(){
        print("Puzzle:\n")
        SudokuSolver.printSudoku(sudoku1)
        if let solution = SudokuSolver.solve(sudoku1){
            print("\nSolution:\n")
            SudokuSolver.printSudoku(solution)
            
        }else{
            print("No Solution")
        }
        
    }
    
    func findAllSolutions(){
        print("\nPuzzle:")
        SudokuSolver.printSudoku(sudoku2)
        var solutionCount = 0
        SudokuSolver.findAllSolutions(for: sudoku2){ solution in
            solutionCount += 1
            
            print("\nSolution \(solutionCount):\n")
            SudokuSolver.printSudoku(solution)
            return true
        }
        if solutionCount == 0{
            print("No Solution")
        }
          
    }
}
