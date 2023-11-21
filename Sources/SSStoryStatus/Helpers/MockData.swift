//
//  MockData.swift
//  SSStoryStatusDemo
//
//  Created by Krunal Patel on 26/10/23.
//

import Foundation

let mockImage: String = "https://fastly.picsum.photos/id/642/200/300.jpg?hmac=P8pCy5u7t4JlHkwIUFsWxnCfi2bWmYGey75V_299YPg"
let storyImage: String = "https://statusneo.com/wp-content/uploads/2023/02/MicrosoftTeams-image551ad57e01403f080a9df51975ac40b6efba82553c323a742b42b1c71c1e45f1.jpg"
let storyVideo: String = "https://pixabay.com/de/videos/wasserfall-tropisch-iguazu-f%C3%A4llt-314/"

var mockData: [UserModel] = [
    UserModel(name: "Krunal", image: mockImage, stories: [StoryModel(mediaURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTjYFV-bwRLTx5vbXeIRyRZDH86KNG-4ktGcg&usqp=CAU", date: Date.now, information: "navratri Party Plot", duration: 80, mediaType: .image), StoryModel(mediaURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRjiAvd2lSst2yi1fvBeCltKLQVXa6U2zauOQ&usqp=CAU", date: Date.now, information: "Anand No Garbo", duration: 70, mediaType: .image),StoryModel(mediaURL: storyVideo, date: Date.now, information: "Don Meldi", duration: 40, mediaType: .video), StoryModel(mediaURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRm6CVrl8BimLX4FacbKqkx9MrcQmaGQCOwPw&usqp=CAU", date: Date.distantPast, information: "Small Girl", duration: 6, mediaType: .image)]),
    
    UserModel(name: "Rahul", image: mockImage, stories: [StoryModel(mediaURL: storyImage, date: Date.now, information: "navratri Party Plot", duration: 10, mediaType: .image, storyState: .seen), StoryModel(mediaURL: storyImage, date: Date.now, information: "Anand No Garbo", duration: 10, mediaType: .image, storyState: .seen), StoryModel(mediaURL: storyVideo, date: Date.now, information: "Don Meldi", duration: 10, mediaType: .video, storyState: .seen) ]),

    UserModel(name: "Ankit", image: mockImage, stories: [StoryModel(mediaURL: storyImage, date: Date.now, information: "navratri Party Plot", duration: 10, mediaType: .image), StoryModel(mediaURL: storyImage, date: Date.now, information: "Anand No Garbo", duration: 10, mediaType: .image), StoryModel(mediaURL: storyVideo, date: Date.now, information: "Don Meldi", duration: 10, mediaType: .video) ]),

    UserModel(name: "Parth", image: mockImage, stories: [StoryModel(mediaURL: storyImage, date: Date.now, information: "navratri Party Plot", duration: 10, mediaType: .image, storyState: .seen), StoryModel(mediaURL: storyImage, date: Date.now, information: "Anand No Garbo", duration: 10, mediaType: .image), StoryModel(mediaURL: storyVideo, date: Date.now, information: "Don Meldi", duration: 10, mediaType: .video, storyState: .seen) ]),

    UserModel(name: "Ruchit", image: mockImage, stories: [StoryModel(mediaURL: storyImage, date: Date.now, information: "navratri Party Plot", duration: 10, mediaType: .image, storyState: .seen), StoryModel(mediaURL: storyImage, date: Date.now, information: "Anand No Garbo", duration: 10, mediaType: .image, storyState: .seen), StoryModel(mediaURL: storyVideo, date: Date.now, information: "Don Meldi", duration: 10, mediaType: .video, storyState: .seen) ]),
    
    UserModel(name: "Rahul", image: mockImage, stories: [StoryModel(mediaURL: storyImage, date: Date.now, information: "navratri Party Plot", duration: 10, mediaType: .image), StoryModel(mediaURL: storyImage, date: Date.now, information: "Anand No Garbo", duration: 10, mediaType: .image), StoryModel(mediaURL: storyVideo, date: Date.now, information: "Don Meldi", duration: 10, mediaType: .video) ]),

    UserModel(name: "Ankit", image: mockImage, stories: [StoryModel(mediaURL: storyVideo, date: Date.now, information: "Don Meldi", duration: 10, mediaType: .video, storyState: .seen) ])
]
