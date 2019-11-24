//
//  AboutView.swift
//  Bullseye
//
//  Created by Alex Grimes on 11/23/19.
//  Copyright © 2019 Alex Grimes. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    
    let backgroundColor = Color(red: 255.0/255.0, green: 214.0/255.0, blue: 179.0/255.0)
    
    struct TextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .font(Font.custom("Arial Rounded MT Bold", size: 16))
                .foregroundColor(.black)
                .padding(.leading, 60)
                .padding(.trailing, 60)
                .padding(.bottom, 20)
                .multilineTextAlignment(.center)
        }
    }
    
    var body: some View {
        Group {
            VStack {
                Text("🎯 Bullseye 🎯")
                    .font(Font.custom("Arial Rounded MT Bold", size: 30))
                    .foregroundColor(.black)
                    .padding(.top, 20)
                    .padding(.bottom, 20)
                    .multilineTextAlignment(.center)
                Text("This is Bullseye, the game where you can win points and earn fame by dragging a slider.")
                    .modifier(TextStyle())
                Text("Your goal is to place the slider as close as possible to the target value. The closer you are, the more points you score.")
                    .modifier(TextStyle())
                Text("Enjoy!")
                    .modifier(TextStyle())
            }
            .navigationBarTitle("About Bullseye")
            .background(backgroundColor)
            .cornerRadius(15)
        }.background(Image("Background"))
        .padding(.leading, 20)
        .padding(.trailing, 20)
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView().previewLayout(.fixed(width: 896, height: 414))
    }
}
