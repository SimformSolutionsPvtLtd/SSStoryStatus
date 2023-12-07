![SSStoryStatus][Banner]

# SSStoryStatus

<!-- Badges -->

[![Swift Compatibility-badge]][Swift Package Index]
[![Platform Compatibility-badge]][Swift Package Index]
[![Release-badge]][Release]
[![License Badge-badge]][license]
[![Pod Version-badge]][CocoaPods]
[![SPM Compatible-badge]][Swift Package Manager]

<!-- Description -->

SSStoryStatus is a versatile and intuitive SwiftUI library designed to effortlessly display user lists and seamlessly showcase their captivating stories. This library empowers developers to effortless integration of user listings with story viewing functionality. This library provides complete control over view components for UI customization.

<!-- Previews -->

|      Profile Listing       |      Story View       |      Message & Reaction     |
|:--------------------------:|:---------------------:|:---------------------------:|
| <img width=260px src="https://github.com/SimformSolutionsPvtLtd/SSStoryStatus/assets/147126103/90b850b7-8354-4209-a41d-e9e73401c075" /> | <img width=260px src="https://github.com/SimformSolutionsPvtLtd/SSStoryStatus/assets/147126103/8fc5a466-4cbe-487d-9d0f-6d1f91b4c77f" /> | <img width=260px src="https://github.com/SimformSolutionsPvtLtd/SSStoryStatus/assets/147126103/ec578a64-73f6-456d-8c94-681ae9126036" /> |

## Features

- [x] Image & Video stories
- [x] Customizable component with styles
- [x] Built-in caching support
- [x] Callback on story seen
- [x] Reaction emojis and message
- [x] Story caption support

## Installation

### Swift Package Manager

You can install `SSStoryStaus` using [Swift Package Manager] by:

1. Go to `Xcode` -> `File` -> `Add Package Dependencies...`
2. Add package URL [https://github.com/SimformSolutionsPvtLtd/SSStoryStatus][SSStoryStatus]

### CocoaPods

[CocoaPods][CocoaPods.org] is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

Navigate to project root folder to integrate pod.

```bash
$ pod init
```

It will generate `Podfile` for your project. To integrate SSStoryStatus into your project specify it in your `Podfile`:

```ruby
platform :ios, '17.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'SSStoryStatus'
end
```

Then, run the following command:

```bash
$ pod install
```

It will generate `<Project>.xcworkspace` file. From now on you should open the project using this file.

## Usage

First import required package:

```swift
import SSStoryStatus
```

`SSStoryStatus` accepts list of Users as `UserModel`.

```swift
let users: [UserModel] = [
    UserModel(
        id: UUID().uuidString, // Unique identifier for user (optional, uses UUID by default)
        name: "Krunal",        // Name of user
        image: "",             // URL of profile image
        stories: stories,      // List of story for this user
    )
]
```

`UserModel` accepts stories for each user as list of `StoryModel`.

```swift
let stories: [StoryModel] = [
    StoryModel(
        id: UUID().uuidString,  // Unique identifier for story (optional, uses UUID by default)
        mediaURL: "",           // Media url of image or video
        date: .now,             // Story creation date
        caption: "",            // Caption for the story (optional)
        mediaType: .image,      // Media type: image or video
        storyState: .seen       // Story is seen or unseen
    )
]
```

Now, you can pass this list of user to `SSStoryStatus`.

```swift
SSStoryStatus(
    users: users,            // List of users
    sorted: true,            // Whether the users should be sorted based on their seen status (default is false)
    cacheExpire: expireDate  // Date indicating cache expiration time (default is 24 hours)
)
```

You can listen to callback when user see any story:

```swift
SSStoryStatus(users: users)
    .onStorySeen { user, storyIndex in
        print("Seen - ", user.stories[storyIndex].mediaURL) // You can retrieve story instance using user and storyIndex
    }
```

When user press any emoji or reply to story you can observe it:

```swift
SSStoryStatus(users: users)
    .emoji { emoji, user, storyIndex in
        print("Selected \(emoji) for story \(user.stories[storyIndex].id)") // Emoji pressed by user
    }
    .messageField { message, user, storyIndex in
        print("Sent \(message) to \(user.name)") // Message sent
    }   
```

## Customization

For customizing SSStoryStatus please refer [Customization Guide].

## Find this samples useful? :heart:

Support it by joining [stargazers] :star: for this repository.

## How to Contribute :handshake:

Whether you're helping us fix bugs, improve the docs, or a feature request, we'd love to have you! :muscle: \
Check out our __[Contributing Guide]__ for ideas on contributing.

## Bugs and Feedback

For bugs, feature feature requests, and discussion use [GitHub Issues].

## Other Mobile Libraries

Check out our other libraries [Awesome-Mobile-Libraries].

## License

Distributed under the MIT license. See [LICENSE] for details.

<!-- Reference links -->

[Banner]:                   https://github.com/SimformSolutionsPvtLtd/SSStoryStatus/assets/147126103/c5cb3bc9-3a63-4260-a8ff-6345ef1559c0

[SSStoryStatus]:            https://github.com/SimformSolutionsPvtLtd/SSStoryStatus

[Swift Package Manager]:    https://www.swift.org/package-manager

[Swift Package Index]:      https://swiftpackageindex.com/SimformSolutionsPvtLtd/SSStoryStatus

[CocoaPods]:                https://cocoapods.org/pods/SSStoryStatus

[CocoaPods.org]:            https://cocoapods.org/

[Release]:                  https://github.com/SimformSolutionsPvtLtd/SSStoryStatus/releases/leatest

[Customization Guide]:      docs/Customization.md

[stargazers]:               https://github.com/SimformSolutionsPvtLtd/SSStoryStatus/stargazers

[Contributing Guide]:       CONTRIBUTING.md

[Github Issues]:            https://github.com/SimformSolutionsPvtLtd/SSStoryStatus/issues

[Awesome-Mobile-Libraries]: https://github.com/SimformSolutionsPvtLtd/Awesome-Mobile-Libraries

[license]:                  LICENSE

<!-- Badges -->

[Platform Compatibility-badge]: https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FSimformSolutionsPvtLtd%2FSSStoryStatus%2Fbadge%3Ftype%3Dplatforms

[Swift Compatibility-badge]:    https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FSimformSolutionsPvtLtd%2FSSStoryStatus%2Fbadge%3Ftype%3Dswift-versions

[Release-badge]:                https://img.shields.io/github/v/release/SimformSolutionsPvtLtd/SSStoryStatus

[License Badge-badge]:          https://img.shields.io/github/license/SimformSolutionsPvtLtd/SSStoryStatus

[Pod Version-badge]:            https://img.shields.io/cocoapods/v/SSStoryStatus

[SPM Compatible-badge]:         https://img.shields.io/badge/Swift_Package_Manager-compatible-coolgreen
