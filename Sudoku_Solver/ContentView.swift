//
//  ContentView.swift
//  Sudoku_Solver
//
//  Created by Sarthak Agrawal on 31/08/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        Button {
            viewModel.solve()
        } label: {
            Text("Solve")
        }
        Button {
            viewModel.findAllSolutions()
        } label: {
            Text("Find all solutions")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
