//
//  ContentView.swift
//  guessFlag
//
//  Created by Alice Nedosekina on 28/11/2020.
//

import SwiftUI

func generateSet (initalSet: [String]) -> [String]{
    var result: [Int] = []
    while result.count < 3 {
        let random = Int.random(in: 0..<initalSet.count)
        if result.firstIndex(of: random) == nil {
            result.append(random)
        }
    }
    let generatedSet: [String] = [ initalSet[ result[0] ], initalSet[ result[1] ], initalSet[ result[2] ] ]
    return generatedSet
}

struct ContentView: View {
    
    @State private var score = 0
    @State private var guessed = false
    @State private var showAlert = false
    @State private var generatedSet: [String] = ["", "", ""]
    
    var currentCountry: Int = {
        return Int.random(in: 0..<3)
    }()
    
    
    let allCountries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    
    var a: Int {
        return allCountries.count
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .bottom, endPoint: .top)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                Text("Tap on the flag of")
                    .foregroundColor(.white)
                Text("\(generatedSet[currentCountry])")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Spacer()
                Text("Score: \(score)")
                    .foregroundColor(.white)
                Spacer()
                
                ForEach(0..<3) { i in
                    Button(action: {
                        if generatedSet[ i ] == generatedSet[currentCountry] {
                            guessed = true
                            score += 1
                        } else {
                            guessed = false
                            score -= 1
                        }
                        
                        self.showAlert = true
                        
                    }, label: {
                        Image("\(generatedSet[ i ])")
                            .cornerRadius(100)
                    })
                    
                    //alert handling
                    .alert(isPresented: $showAlert) {
                        
                        if guessed {
                            return Alert(title: Text("Congrats"),
                                         message: Text("This was a correct flag!"),
                                         dismissButton: .default(Text("Again"), action: {
                                            generatedSet = generateSet(initalSet: allCountries)
                                         }))
                        } else {
                            return Alert(title: Text("Oh no!"),
                                         message: Text("This was not a correct flag"),
                                         dismissButton: .default(Text("Try again"), action: {
                                            generatedSet = generateSet(initalSet: allCountries)
                                         }))
                        }
                    }
                }
                
                Spacer()
            }
        }
        //initial state
        .onAppear(perform: {
            generatedSet = generateSet(initalSet: allCountries)
            print(generatedSet)
        })
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
