//
//  StoryViewModel.swift
//  SSStoryStatus
//
//  Created by Krunal Patel on 26/10/23.
//

import SwiftUI
import Observation

@Observable
class StoryViewModel {
    
    // MARK: - Vars & Lets
    var userList: [UserModel]
    var currentUser: UserModel?
    var isStoryPresented = false
    var isZoomed: Bool = false
    private let isSorted: Bool
    
    // MARK: - Methods
    func viewStory(of user: UserModel) {
        currentUser = user
        isStoryPresented = true
    }
    
    func nextUser() {
        guard let index = getCurrentUserIndex(),
              index + 1 < userList.count else {
            stopStoryPresent()
            return
        }
        currentUser = userList[index + 1]
    }
    
    func previousUser() {
        guard let index = getCurrentUserIndex(),
              index > 0 else {
            stopStoryPresent()
            return
        }
        currentUser = userList[index - 1]
    }
    
    func storySeen(user: UserModel, storyIndex: Int) {
        guard let index = userList.firstIndex(of: user) else { return }
        
        userList[index].stories[storyIndex].storyState = .seen
        
        if isSorted {
            sortUserBySeen()
        }
    }
    
    func stopStoryPresent() {
        isStoryPresented = false
        currentUser = nil
    }
    
    private func getCurrentUserIndex() -> Int? {
        guard let currentUser,
              let index = userList.firstIndex(where: { $0.id == currentUser.id }) else {
            return nil
        }
        return index
    }
    
    func sortUserBySeen() {
        userList.sort { !$0.isAllStoriesSeen && $1.isAllStoriesSeen }
    }
    
    // MARK: - Initializer
    init(userList: [UserModel], sorted: Bool = false) {
        self.userList = userList
        isSorted = sorted
        if sorted {
            sortUserBySeen()
        }
    }
}
