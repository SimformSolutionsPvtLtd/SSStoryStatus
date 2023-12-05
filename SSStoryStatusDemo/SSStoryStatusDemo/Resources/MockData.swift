//
//  MockData.swift
//  SSStoryStatusDemo
//
//  Created by Krunal Patel on 26/10/23.
//

import SSStoryStatus
import Foundation

let mockImage: String = "https://fastly.picsum.photos/id/642/200/300.jpg?hmac=P8pCy5u7t4JlHkwIUFsWxnCfi2bWmYGey75V_299YPg"
let mockImages = [
    "https://plus.unsplash.com/premium_photo-1661515449711-ace459054f78?auto=format&fit=crop&q=60&w=500&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8bWFsZSUyMHByb2ZpbGV8ZW58MHx8MHx8fDA%3D",
    "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&q=60&w=500&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8bWFsZSUyMHByb2ZpbGV8ZW58MHx8MHx8fDA%3D",
    "https://images.unsplash.com/photo-1480455624313-e29b44bbfde1?auto=format&fit=crop&q=60&w=500&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8bWFsZSUyMHByb2ZpbGV8ZW58MHx8MHx8fDA%3D"
]
let storyImage: String = "https://statusneo.com/wp-content/uploads/2023/02/MicrosoftTeams-image551ad57e01403f080a9df51975ac40b6efba82553c323a742b42b1c71c1e45f1.jpg"
let storyVideo: String = "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4"

let storyImages = ["https://wepik.com/api/image/ai/9a7fbea5-525b-4dd3-a3fe-3385dbb97c38?thumb=1",
                   "https://wepik.com/api/image/ai/9a7fbeda-6fd2-40c9-aa1d-a26d47807c03?thumb=1",
                   "https://wepik.com/api/image/ai/9a7fbf00-20e2-4650-a4bc-5f90f34b73ae?thumb=1"
]

var mockData: [UserModel] = [
//    
    UserModel(name: "Rahul", image: mockImage, stories: [StoryModel(mediaURL: storyImages[0], date: Date.randomBetween(), information: "navratri Party Plot", duration: 10, mediaType: .image, storyState: .seen), StoryModel(mediaURL: storyImages[1], date: Date.randomBetween(), information: "Anand No Garbo", duration: 10, mediaType: .image, storyState: .seen), StoryModel(mediaURL: storyImages[2], date: Date.randomBetween(), information: "Don Meldi", duration: 10, mediaType: .video, storyState: .seen) ]),
    
    UserModel(name: "Krunal", image: mockImage, stories: [StoryModel(mediaURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTjYFV-bwRLTx5vbXeIRyRZDH86KNG-4ktGcg&usqp=CAU", date: Date.randomBetween(), information: "navratri Party Plot", duration: 80, mediaType: .image), StoryModel(mediaURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRjiAvd2lSst2yi1fvBeCltKLQVXa6U2zauOQ&usqp=CAU", date: Date.randomBetween(), information: "Anand No Garbo", duration: 70, mediaType: .image),StoryModel(mediaURL: storyVideo, date: Date.randomBetween(), information: "Don Meldi", duration: 40, mediaType: .video), StoryModel(mediaURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRm6CVrl8BimLX4FacbKqkx9MrcQmaGQCOwPw&usqp=CAU", date: Date.randomBetween(), information: "Small Girl", duration: 6, mediaType: .image)]),

    UserModel(name: "Ankit", image: mockImage, stories: [StoryModel(mediaURL: storyImages[0], date: Date.randomBetween(), information: "navratri Party Plot", duration: 10, mediaType: .image), StoryModel(mediaURL: storyImages[1], date: Date.randomBetween(), information: "Anand No Garbo", duration: 10, mediaType: .image), StoryModel(mediaURL: storyImages[2], date: Date.randomBetween(), information: "Don Meldi", duration: 10, mediaType: .video) ]),

    UserModel(name: "Parth", image: mockImage, stories: [StoryModel(mediaURL: storyImages[0], date: Date.randomBetween(), information: "navratri Party Plot", duration: 10, mediaType: .image, storyState: .seen), StoryModel(mediaURL: storyImages[1], date: Date.randomBetween(), information: "Anand No Garbo", duration: 10, mediaType: .image), StoryModel(mediaURL: storyImages[2], date: Date.randomBetween(), information: "Don Meldi", duration: 10, mediaType: .video, storyState: .seen) ]),

    UserModel(name: "Ruchit", image: mockImage, stories: [StoryModel(mediaURL: storyImages[0], date: Date.randomBetween(), information: "navratri Party Plot", duration: 10, mediaType: .image, storyState: .seen), StoryModel(mediaURL: storyImages[1], date: Date.randomBetween(), information: "Anand No Garbo", duration: 10, mediaType: .image, storyState: .seen), StoryModel(mediaURL: storyImages[2], date: Date.randomBetween(), information: "Don Meldi", duration: 10, mediaType: .video, storyState: .seen) ]),
    
    UserModel(name: "Rahul", image: mockImage, stories: [StoryModel(mediaURL: storyImages[0], date: Date.randomBetween(), information: "navratri Party Plot", duration: 10, mediaType: .image), StoryModel(mediaURL: storyImages[1], date: Date.randomBetween(), information: "Anand No Garbo", duration: 10, mediaType: .image), StoryModel(mediaURL: storyImages[2], date: Date.randomBetween(), information: "Don Meldi", duration: 10, mediaType: .video) ]),

    UserModel(name: "Ankit", image: mockImage, stories: [StoryModel(id: "test_video" ,mediaURL: storyVideo, date: Date.randomBetween(), information: "Don Meldi", duration: 10, mediaType: .video, storyState: .seen) ]),
    
    UserModel(name: "Ankit", image: mockImage, stories: [StoryModel(id: "test_video" ,mediaURL: storyVideo, date: Date.randomBetween(), information: "Don Meldi", duration: 10, mediaType: .video, storyState: .seen) ]),
    
    UserModel(name: "Ankit", image: mockImage, stories: [StoryModel(id: "test_video" ,mediaURL: storyVideo, date: Date.randomBetween(), information: "Don Meldi", duration: 10, mediaType: .video, storyState: .seen) ]),
    
    UserModel(name: "KP1", image: mockImages[0], stories: [StoryModel(id: "test_video" ,mediaURL: storyImages[0], date: Date.randomBetween(), information: "Don Meldi", duration: 10, mediaType: .image, storyState: .seen) ]),
    UserModel(name: "KP2", image: mockImages[1], stories: [StoryModel(id: "test_video1" ,mediaURL: storyImages[1], date: Date.randomBetween(), information: "Don Meldi", duration: 11, mediaType: .image, storyState: .seen) ]),
    UserModel(name: "KP3", image: mockImages[2], stories: [StoryModel(id: "test_video2" ,mediaURL: storyImages[2], date: Date.randomBetween(), information: "Don Meldi", duration: 12, mediaType: .image, storyState: .seen) ]),
]

extension Date {
    
    static func randomBetween(start: Date = Calendar.current.date(byAdding: .day, value: -1, to: .now)!, end: Date = .now) -> Date {
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
