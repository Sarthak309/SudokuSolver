//
//  SudokuSolver.swift
//  Sudoku_Solver
//
//  Created by Sarthak Agrawal on 31/08/23.
//

import Foundation

public struct SudokuMark{
    public let value: Int
    
    public init(_ value: Int) {
        assert(1 <= value && value <= 9,"only values between 1 and 9 are allowed")
        
        switch value{
        case 1...9:
            self.value = value
        default:
            self.value = 1
        }
        
    }
}

public enum SudokuSquare: ExpressibleByIntegerLiteral {
    case empty
    case marked(SudokuMark)
    
    public init(integerLiteral value: IntegerLiteralType) {
        switch value{
        case 1...9:
            self = .marked(SudokuMark(value))
        default:
            self = .empty
        }
    }
    
    var isEmpty: Bool {
        switch self{
        case .empty:
            return true
        case .marked(_):
            return false
        }
    }
    
    func isMaarkedWithValue(_ value:Int) -> Bool{
        switch self{
        case .empty:
            return false
        case .marked(let sudokuMark):
            return sudokuMark.value == value
        }
    }
}

public typealias Sudoku = [[SudokuSquare]]

struct SudokuSolver{
    
    private static func does(_ sudoku: Sudoku, containMark mark: Int, inRow row: Int) -> Bool {
        for col in 0..<9{
            if sudoku[row][col].isMaarkedWithValue(mark){
                return true
            }
        }
        return false
    }
    
    private static func does(_ sudoku: Sudoku, containMark mark: Int, inColumn col: Int) -> Bool {
        for row in 0..<9{
            if sudoku[row][col].isMaarkedWithValue(mark){
                return true
            }
        }
        return false
    }
    
    private static func does(_ sudoku: Sudoku, containMark mark: Int, in3x3BoxWithRow row: Int, in3x3BoxWithColumn col: Int) -> Bool {
        
        let boxMinRow = (row / 3) * 3
        let boxMaxRow = boxMinRow + 2
        
        let boxMinCol = (col / 3) * 3
        let boxMaxCol = boxMinCol + 2
        
        for row in boxMinRow...boxMaxRow{
            for col in boxMinCol...boxMaxCol{
                if sudoku[row][col].isMaarkedWithValue(mark){
                    return true
                }
            }
        }
        return false
    }
    
    private static func isValid(_ mark: Int, atRow row: Int, atCol col: Int, inSudoku sudoku: Sudoku) -> Bool{
        !does(sudoku, containMark: mark, inRow: row) && !does(sudoku, containMark: mark, inColumn: col) && !does(sudoku, containMark: mark, in3x3BoxWithRow: row, in3x3BoxWithColumn: col)
    }
    
    private static func findEmptySquare(in sudoku: Sudoku) -> (Int, Int)?{
        for row in 0..<9{
            for col in 0..<9{
                if sudoku[row][col].isEmpty{
                    return (row,col)
                }
            }
        }
        return nil
    }
    
    private static func candidateSudoku(_ sudoku: Sudoku, withMark mark: Int, atRow row: Int, atCol col: Int) -> Sudoku{
        var result = Sudoku(sudoku)
        
        var newRow = Array(sudoku[row])
        newRow[col] = .marked(SudokuMark(mark))
        result[row] = newRow
        
        return result
    }
    
    public static func solve(_ sudoku: Sudoku) -> Sudoku? {
        if let (row,col) = findEmptySquare(in: sudoku) {
            for mark in 1...9 {
                if isValid(mark, atRow: row, atCol: col, inSudoku: sudoku){
                    let candidate = candidateSudoku(sudoku, withMark: mark, atRow: row, atCol: col)
                    if let solution = solve(candidate){
                        return solution
                    }
                }
            }
            return nil
        }else{
            return sudoku
        }
    }
    
    public static func printSudoku(_ sudoku:Sudoku){
        for i in 0..<sudoku.count{
            if i % 3 == 0, i != 0 {
                print("-----------------------")
            }
            let row = sudoku[i]
            for j in 0..<row.count{
                if j % 3 == 0, j != 0{
                    print(" | ",terminator: "")
                }
                let square = row[j]
                switch square {
                case .empty:
                    print("-", terminator: "")
                case .marked(let mark):
                    print(mark.value, terminator: "")
                }
            }
            print()
        }
    }
    
    public static func findAllSolutions(for sudoku:Sudoku, processAndContinue: @escaping(Sudoku)-> Bool){
        var stop = false
        
        var recursiveCall: (Sudoku) -> () = {_ in return}
        
        func findSolutionUntilStop(_ sudoku: Sudoku){
            if let (row, col) = findEmptySquare(in: sudoku){
                for mark in 1...9{
                    if stop{
                        break
                    }
                    if isValid(mark, atRow: row, atCol: col, inSudoku: sudoku){
                        let candidate = candidateSudoku(sudoku, withMark: mark, atRow: row, atCol: col)
                        recursiveCall(candidate)
                    }
                    
                }
            }else{
                if !processAndContinue(sudoku){
                    stop = true
                }
            }
        }
        recursiveCall = findSolutionUntilStop
        findSolutionUntilStop(sudoku)
    }
}
