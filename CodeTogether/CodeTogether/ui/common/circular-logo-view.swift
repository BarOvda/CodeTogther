//
//  circular-logo-view.swift
//  CodeTogether
//
//  Created by user on 30/06/2021.
//
//
import SwiftUI

struct CircularLogoView: View {
    var body: some View {
        HStack{
            Spacer()
            Image("logo")
                .resizable()
                .cornerRadius(75)
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            Spacer()
            
        }
    }
}

struct circular_logo_view_Previews: PreviewProvider {
    static var previews: some View {
        CircularLogoView()
    }
}
