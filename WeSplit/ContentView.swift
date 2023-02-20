//
//  ContentView.swift
//  WeSplit
//
//  Created by Jason on 2/19/23.
//

import SwiftUI

struct ContentView: View {
    @State private var checkTotal = 0.0
    @State private var numOfPeople = 2
    @State private var tipPercent = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipChoice = [0, 10, 15, 20, 25]
    var totalPerPerson: Double {
        let peopleCount = Double(numOfPeople + 2)
        let tipSelection = Double(tipPercent)
        
        let tipValue = checkTotal / 100 * tipSelection
        let grandTotal = checkTotal + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkTotal, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section {
                    Picker("Tip percentage", selection: $tipPercent) {
                        ForEach(tipChoice, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Tip you'd like to add?")
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
