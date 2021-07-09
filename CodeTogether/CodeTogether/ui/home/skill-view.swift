//
//  skill-view.swift
//  CodeTogether
//
//  Created by user on 30/06/2021.
//

import SwiftUI

struct SkillView: View {

    @State var skill: String? = "Kotlin"

    var body: some View {
        Text(skill!)
            .padding(10)
            .font(.system(size: 12))
           
    }
}

struct skill_view_Previews: PreviewProvider {
    static var previews: some View {
        SkillView()
    }
}
