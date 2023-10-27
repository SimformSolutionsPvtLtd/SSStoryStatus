//
//  StoryViewModel.swift
//
//
//  Created by Krunal Patel on 26/10/23.
//

import Foundation
import Observation

@Observable
class StoryViewModel {
    
    @ObservationIgnored var userList: [UserModel]
    var currentUser: UserModel
    {
        didSet {
            print(currentUser)
        }
    }
    var isStoryPresented = false
    
    func viewStory(of user: UserModel) {
        currentUser = user
        isStoryPresented = true
    }
    
    func nextUser() {
        guard let index = getCurrentUserIndex(),
              index + 1 < userList.count else {
            isStoryPresented = false
            return
        }
        currentUser = userList[index + 1]
    }
    
    func previousUser() {
        guard let index = getCurrentUserIndex(),
              index > 0 else {
            isStoryPresented = false
            return
        }
        currentUser = userList[index - 1]
    }
    
    func closeStoryView() {
        isStoryPresented = false
    }
    
    private func getCurrentUserIndex() -> Int? {
        guard let index = userList.firstIndex(of: currentUser) else {
            return nil
        }
        return index
    }
    
    init(userList: [UserModel]) {
        self.userList = userList
        self.currentUser = userList[0]
    }
}
