//
//  ContentView.swift
//  Bullseye
//
//  Created by Alex Grimes on 11/23/19.
//  Copyright © 2019 Alex Grimes. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var alertIsVisible = false
    @State var sliderValue = 50.0
    @State var targetValue = Int.random(in: 1...100)
    @State var score = 0
    @State var round = 1
    
    let midnightBlue = Color(red: 0.0/255.0, green: 51.0/255.0, blue: 102.0/255.0)
    
    struct LabelStyle: ViewModifier {
        
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.white)
                .modifier(ShadowStyle())
                .font(Font.custom("Arial Rounded MT Bold", size: 18))
        }
    }
    
    struct ValueStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(.yellow)
                .modifier(ShadowStyle())
                .font(Font.custom("Arial Rounded MT Bold", size: 24))
        }
    }
    
    struct ShadowStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .shadow(color: .black, radius: 5, x: 2, y: 2)
        }
    }
    
    struct ButtonLargeTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(.black)
                .font(Font.custom("Arial Rounded MT Bold", size: 18))
        }
    }
    
    struct ButtonSmallTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(.black)
                .font(Font.custom("Arial Rounded MT Bold", size: 12))
        }
    }

    var body: some View {
        VStack {
            Spacer()
            
            // Target row
            HStack {
                Text("Put the bullseye as close as you can to:")
                    .modifier(LabelStyle())
                Text("\(targetValue)")
                    .modifier(ValueStyle())
            }
            
            Spacer()
            
            // Slider row
            HStack {
                Text("1")
                Slider(value: $sliderValue, in: 1...100).accentColor(.green)
                Text("100")
            }
            
            Spacer()
            
            // Button row
            Button(action: {
                print("Button pressed")
                self.alertIsVisible = true
                
            }) {
                Text(/*@START_MENU_TOKEN@*/"Hit Me!"/*@END_MENU_TOKEN@*/).modifier(ButtonLargeTextStyle())
            }
            .alert(isPresented: $alertIsVisible) { () -> Alert in
                let roundedValue = sliderValueRounded()
                let points = pointsForCurrentRound()
                return Alert(title: Text("\(alertTitle())"), message: Text("The slider's value is \(roundedValue).\nYou scored \(points) points this round."), dismissButton: .default(Text("Dismiss")) {
                    self.score += self.pointsForCurrentRound()
                    self.round += 1
                    self.targetValue = Int.random(in: 1...100)
                })
            }
            .background(Image("Button"), alignment: .center)
            .modifier(ShadowStyle())
            
            Spacer()
            
            // Score row
            HStack {
                Button(action: {
                    self.startOverTapped()
                }) {
                    HStack {
                        Image("StartOverIcon")
                        Text("Start Over").modifier(ButtonSmallTextStyle())
                    }
                }
                .background(Image("Button"), alignment: .center)
                .modifier(ShadowStyle())
                Spacer()
                Text("Score:").modifier(LabelStyle())
                Text("\(score)").modifier(ValueStyle())
                Spacer()
                Text("Round:").modifier(LabelStyle())
                Text("\(round)").modifier(ValueStyle())
                Spacer()
                NavigationLink(destination: AboutView()) {
                    HStack {
                        Image("InfoIcon")
                        Text("Info").modifier(ButtonSmallTextStyle())
                    }
                }
                .background(Image("Button"), alignment: .center)
                .modifier(ShadowStyle())
            }.padding(.bottom, 20)
        }
        .background(Image("Background"), alignment: .center)
        .accentColor(midnightBlue)
        .navigationBarTitle("Bullseye")
        .padding(.leading, 20)
        .padding(.trailing, 30)
    }
    
    func pointsForCurrentRound() -> Int {
        let diff = difference()
        let base = 100 - diff
        var extra = 0
        if diff == 0 {
            extra = 100
        } else if diff == 1 {
            extra = 50
        }
        return base + extra
    }
    
    func sliderValueRounded() -> Int {
        return  Int(sliderValue.rounded())
    }
    
    func difference() -> Int {
        return abs(targetValue - sliderValueRounded())
    }
    
    func alertTitle() -> String {
        let title: String
        let diff = difference()
        if diff == 0 {
            title = "Perfect!"
        } else if diff < 5 {
            title = "You almost had it!"
        } else if diff < 10 {
            title = "Not bad."
        } else {
            title = "Not even close!"
        }
        return title
    }
    
    func startOverTapped() {
        score = 0
        round = 1
        sliderValue = 50.0
        targetValue = Int.random(in: 1...100)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 896, height: 414))
    }
}
