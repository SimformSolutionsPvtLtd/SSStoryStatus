# Getting Started with SSStoryStatus

Create profile listing and display story view.

## Overview

SSStoryStatus provides easy integration for the story view and profile listing.

### Usage

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

### Getting callbacks

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

## Featured

- <doc:Customization>
