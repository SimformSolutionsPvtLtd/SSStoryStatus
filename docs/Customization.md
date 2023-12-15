# Customizing SSStoryStatus

## Profile Listing

![Profile Listing-preview]

To customize the profile listing you can use `profileListStyle` view modifier.

For customizing profile view refer [Profile View](#profile-view).

```swift
SSStoryStatus(users: users)
    .profileListStyle(.automatic.horizontalSpacing(14))
```

You can use default style with `ProfileListStyle.automatic` and customize with available methods.
Alternatively, you can provide custom type that confirms to `ProfileListStyle` protocol.

Please refer [ProfileListStyle] documentation for more detail.

## Profile View

![Profile View-preview]

Profile views displayed in profile listed can be customized with the `profileStyle` view modifier.

```swift
SSStoryStatus(users: users)
    .profileStyle(.automatic.profileSize(width: 80, height: 80))
```

You can use default style with `ProfileStyle.automatic` and customize with available methods.
Alternatively, you can provide custom type that confirms to `ProfileStyle` protocol.

Please refer [ProfileStyle] documentation for more detail.

## Story Styling

Use `storyStyle` view modifier to configure different components of story view.

To customize story like image story duration pass the instance of `StoryStyle`.

You can create new instance with custom values.
Alternatively, you can use available methods for specific customization.

```swift
SSStoryStatus(users: mockData)
    .storyStyle(StoryStyle(storyDuration: 15))
```

### Story Header

![Story Header-preview]

To customize story header you can pass type confirming to `StoryHeaderStyle` protocol.

You can use built-in type with `StoryHeaderStyle.automatic` with available customization methods.
Alternatively, you can provide custom type that confirms to `StoryHeaderStyle` protocol.

```swift
SSStoryStatus(users: mockData)
    .storyStyle(headerStyle: .automatic.dismissColor(.gray))
```

For detailed guide please refer [StoryHeaderStyle] documentation.

### Story Footer

![Story Footer-preview]

To customize story footer you can pass type confirming to `StoryFooterStyle` protocol.

You can use built-in type with `StoryFooterStyle.automatic` with available customization methods.
Alternatively, you can provide custom type that confirms to `StoryFooterStyle` protocol.

```swift
SSStoryStatus(users: mockData)
    .storyStyle(footerStyle: .automatic.captionColor(.white))
```

For detailed guide please refer [StoryFooterStyle] documentation.

### Story Progress Bar

![Progress Bar-preview]

To customize progress bar of story you have to pass instance of `ProgressBarStyle`.

You can create new instance with custom values.
Alternatively, you can use available methods for specific customization.

```swift
SSStoryStatus(users: mockData)
    .storyStyle(progressBarStyle: .init(foreground: .linearGradient(colors: [.green, .orange], startPoint: .leading, endPoint: .trailing)))
```

For detailed guide please refer [ProgressBarStyle] documentation.

## Emoji

![Emoji-preview]

You can use custom emoji reactions by providing list of emojis  in `emoji` modifiers.

```swift
SSStoryStatus(users: mockData)
    .emoji(["🪄", "🧙🏼‍♂️", "🔮", "🧚", "🦉"]) { emoji, _, _ in
        print("Selected - ", emoji)
    }
```

You can style the emoji view by providing a type confirming to `EmojiStyle` protocol to `emoji` or `emojiStyle` view modifier.

You can use built-in type with `EmojiStyle.automatic` with available customization methods.
Alternatively, you can provide custom type that confirms to `EmojiStyle` protocol.

```swift
SSStoryStatus(users: mockData)
    .emojiStyle(.automatic(emojiSize: 20))
```

To enable or disable emoji view you can pass boolean value to `emoji` view modifier.

```swift
SSStoryStatus(users: mockData)
    .emoji(isEnabled: false)
```

For detailed guide please refer [EmojiStyle] documentation.

## Message Field

![Message Field-preview]

You can provide custom placeholder of type `Text` by passing to `messageField` view modifier.

```swift
SSStoryStatus(users: mockData)
    .messageField(placeholder: Text("Type something...")) { message, _, _ in
        print("Send - ", message)
    }
```

You can style the message field view by providing a type confirming to `MessageStyle` protocol to `messageField` or `messageStyle` view modifier.

You can use built-in type with `MessageStyle.automatic` with available customization methods.
Alternatively, you can provide custom type that confirms to `MessageStyle` protocol.

```swift
SSStoryStatus(users: mockData)
    .messageStyle(.automatic(messageColor: .white))
```

For detailed guide please refer [MessageStyle] documentation.

## Image Cache

There are two default implementations available `StorageImageCache` and `NSImageCache`.

NSImageCache cache images into NSCache. Cache will be cleared each time application is closed.

StorageImageCache stores the cached images into file system. Cache can be cleared by passing date object to cacheExpire parameter in init(users:sorted:cacheExpire:).

You can also provide custom implementation of ImageCache by confirming to `ImageCache` protocol.

To change image cache use ``changeImageCache``

```swift
SSStoryStatus(users: mockData)
    .changeImageCache(.nscache)
```

For more details take a look at [ImageCache] documentation.

<!-- Documentation Links -->

[ProfileListStyle]: https://swiftpackageindex.com/SimformSolutionsPvtLtd/SSStoryStatus/documentation/ssstorystatus/ProfileListStyle

[ProfileStyle]: https://swiftpackageindex.com/SimformSolutionsPvtLtd/SSStoryStatus/documentation/ssstorystatus/ProfileStyle

[StoryHeaderStyle]: https://swiftpackageindex.com/SimformSolutionsPvtLtd/SSStoryStatus/documentation/ssstorystatus/StoryHeaderStyle

[StoryFooterStyle]: https://swiftpackageindex.com/SimformSolutionsPvtLtd/SSStoryStatus/documentation/ssstorystatus/StoryFooterStyle

[ProgressBarStyle]: https://swiftpackageindex.com/SimformSolutionsPvtLtd/SSStoryStatus/documentation/ssstorystatus/ProgressBarStyle

[EmojiStyle]: https://swiftpackageindex.com/SimformSolutionsPvtLtd/SSStoryStatus/documentation/ssstorystatus/EmojiStyle

[MessageStyle]: https://swiftpackageindex.com/SimformSolutionsPvtLtd/SSStoryStatus/documentation/ssstorystatus/MessageStyle

[ImageCache]: https://swiftpackageindex.com/SimformSolutionsPvtLtd/SSStoryStatus/documentation/ssstorystatus/ImageCache

<!-- Images -->

[Profile Listing-preview]: https://user-images.githubusercontent.com/147126103/290075334-c3b3a402-9f2e-4922-8f5a-26b8b599e638.png

[Profile View-preview]: https://user-images.githubusercontent.com/147126103/290075336-28c3554d-af6c-45f6-8d7b-ec8433a56416.png

[Story Header-preview]: https://user-images.githubusercontent.com/147126103/290075343-ea6eb3f5-6803-4923-b4a8-8432bbcb3af0.png

[Story Footer-preview]: https://user-images.githubusercontent.com/147126103/290075340-a35902fb-cba5-4217-b15b-266f777c43d0.png

[Progress Bar-preview]: https://user-images.githubusercontent.com/147126103/290075337-30667315-edf0-40db-87e5-9c4003dbde6a.png

[Emoji-preview]: https://user-images.githubusercontent.com/147126103/290075322-b6acd3a3-9959-4f5b-a947-5dce1caedc25.png

[Message Field-preview]: https://user-images.githubusercontent.com/147126103/290075329-c44a8fde-a31c-4c09-bd25-82aa1478780a.png
