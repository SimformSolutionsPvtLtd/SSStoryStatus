//
//  MockData.swift
//  SSStoryStatus
//
//  Created by Krunal Patel on 26/10/23.
//

import Foundation

public var mockData: [UserModel] = [
    UserModel(
        name: "Harry Potter",
        image: "https://api.time.com/wp-content/uploads/2014/07/301386_full1.jpg",
        stories: getMockStories(name: "Harry Potter")
    ),
    UserModel(
        name: "Hermione",
        image: "https://i.pinimg.com/564x/d3/39/6d/d3396dae78e4a47541fa3718faca7db2--witch-hair-hermione-granger-costume.jpg",
        stories: getMockStories(name: "Hermione")
    ),
    UserModel(
        name: "Ron Weasley",
        image: "https://theverge.monmouth.edu/wp-content/uploads/sites/792/2017/03/ron-weasley-hp2-scared-1920x1080-1-1200x675.jpg",
        stories: getMockStories(name: "Ron Weasley")
    ),
    UserModel(
        name: "Dumbledore",
        image: "https://drive.usercontent.google.com/download?id=11v_tbgKPflx5BmiO6XiSO0ng7aSKoPbW&export=download",
        stories: getMockStories(name: "Dumbledore")
    ),
    UserModel(
        name: "McGonagall",
        image: "https://i.pinimg.com/564x/21/8c/b1/218cb14172630f21ff88632e67d3079a.jpg",
        stories: getMockStories(name: "McGonagall")
    ),
    UserModel(
        name: "Severus Snape",
        image: "https://drive.usercontent.google.com/download?id=11vgpREETGc0Q_ZhOG_QysEnXT2ME-N5T&export=download",
        stories: getMockStories(name: "Severus Snape")
    ),
    UserModel(
        name: "Lord Voldemort",
        image: "https://w0.peakpx.com/wallpaper/293/810/HD-wallpaper-harry-potter-lord-voldemort-profile-view-movies.jpg",
        stories: getMockStories(name: "Lord Voldemort")
    ),
    UserModel(
        name: "Dementor",
        image: "https://static.wikia.nocookie.net/harrypotter/images/4/49/DementorConceptArt.jpg",
        stories: getMockStories(name: "Dementor")
    ),
    UserModel(
        name: "Dobby",
        image: "https://static.wikia.nocookie.net/harrypotter/images/8/82/Dobby.jpg",
        stories: getMockStories(name: "Dobby")
    )
]

fileprivate func getMockStories(name: String) -> [StoryModel] {
    [
        StoryModel(
            mediaURL: "https://source.unsplash.com/random/?Harry Potter#\(Int.random(in: 0...100))",
            date: Date.randomBetween(),
            mediaType: .image,
            storyState: .seen),
        StoryModel(
            mediaURL: storyVideos[0],
            date: Date.randomBetween(),
            mediaType: .video,
            storyState: .seen),
        StoryModel(
            mediaURL: "https://source.unsplash.com/random/?Harry Potter#\(Int.random(in: 0...100))",
            date: Date.randomBetween(),
            mediaType: .image,
            storyState: .unseen),
        StoryModel(
            mediaURL: storyVideos[1],
            date: Date.randomBetween(),
            mediaType: .video,
            storyState: .unseen),
    ]
}

let storyVideos = ["https://drive.usercontent.google.com/download?id=1pooqb9sW2HNiE9SVxqY2FWjM49mF6B8L&export=download",
                   "https://drive.usercontent.google.com/download?id=1-0MjxLuAesxL8-tLNg9B87KXO2y8sFhR&export=download",
                   "https://storage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
                   "https://storage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
                   "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
                   "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4",
                   "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4",
                   "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
                   "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4",
                   "https://storage.googleapis.com/gtv-videos-bucket/sample/SubaruOutbackOnStreetAndDirt.mp4",
                   "https://storage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4"]

extension Date {
    
    fileprivate static func randomBetween(start: Date = Calendar.current.date(byAdding: .day, value: -1, to: .now)!, end: Date = .now) -> Date {
        var date1 = start
        var date2 = end
        if date2 < date1 {
            let temp = date1
            date1 = date2
            date2 = temp
        }
        let span = TimeInterval.random(in: date1.timeIntervalSinceNow...date2.timeIntervalSinceNow)
        return Date(timeIntervalSinceNow: span)
    }
}
