//
//  project.swift
//  CodeTogether
//
//  Created by user on 05/07/2021.
//

import Foundation

struct Project: Codable, Identifiable {
    var id: UUID? = UUID()
    var project_id: String? = ""
    var name: String? = ""
    var description: String? = ""
    var skills: [String]? = []
    var user_id: String? = ""
    var lat: Double? = 0.0
    var lng: Double? = 0.0
    var no_of_developers: String? = ""
}

