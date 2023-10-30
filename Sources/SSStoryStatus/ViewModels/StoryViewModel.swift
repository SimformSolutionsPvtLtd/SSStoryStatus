//
//  File.swift
//  
//
//  Created by Krunal Patel on 26/10/23.
//

import Foundation

@Observable
class StoryViewModel: ObservableObject {
    
    var userList: [UserModel]
    
    init(userList: [UserModel]) {
        self.userList = userList
    }
}
