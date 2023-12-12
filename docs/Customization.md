# Customizing SSStoryStatus

## Profile Listing

![Profile Listing](https://github.com/SimformSolutionsPvtLtd/SSStoryStatus/assets/147126103/f9c61c56-5e2c-4871-8a38-d83d9b3be077)

To customize the profile listing you can use `profileListStyle` view modifier.

For customizing profile view refer [Profile View](#profile-view).

```swift
SSStoryStatus(users: users)
    .profileListStyle(.automatic.horizontalSpacing(14))
```

You can use default style with `ProfileListStyle.automatic` and customize with available methods.
Alternatively, you can provide custom type that confirms to `ProfileListStyle` protocol.

Please refer `ProfileListStyle` documentation for more detail.

## Profile View

![Profile View](https://github.com/SimformSolutionsPvtLtd/SSStoryStatus/assets/147126103/3632406f-f22d-4112-b4ee-4d790be98d2c)

Profile views displayed in profile listed can be customized with the `profileStyle` view modifier.

```swift
SSStoryStatus(users: users)
    .profileStyle(.automatic.profileSize(width: 80, height: 80))
```

You can use default style with `ProfileStyle.automatic` and customize with available methods.
Alternatively, you can provide custom type that confirms to `ProfileStyle` protocol.

Please refer `ProfileStyle` documentation for more detail.

## Story Styling

You `storyStyle` view modifier to configure different components of story view.

To customize story like image story duration pass the instance of `StoryStyle`.

You can create new instance with custom values.
Alternatively, you can use available methods for specific customization.

```swift
SSStoryStatus(users: mockData)
    .storyStyle(StoryStyle(storyDuration: 15))
```

### Story Header

![Story Header](https://github.com/SimformSolutionsPvtLtd/SSStoryStatus/assets/147126103/ba50c961-8e6a-4ba4-ad02-d66ae69f3ee3)

To customize story header you can pass type confirming to `StoryHeaderStyle` protocol.

You can use built-in type with `StoryHeaderStyle.automatic` with available customization methods.
Alternatively, you can provide custom type that confirms to `StoryHeaderStyle` protocol.

```swift
SSStoryStatus(users: mockData)
    .storyStyle(headerStyle: .automatic.dismissColor(.gray))
```

For detailed guide please refer `StoryHeaderStyle` documentation.

### Story Footer

![Story Footer](https://github.com/SimformSolutionsPvtLtd/SSStoryStatus/assets/147126103/0936b7f5-c354-4b21-bc8b-95cf3b647db0)

To customize story footer you can pass type confirming to `StoryFooterStyle` protocol.

You can use built-in type with `StoryFooterStyle.automatic` with available customization methods.
Alternatively, you can provide custom type that confirms to `StoryFooterStyle` protocol.

```swift
SSStoryStatus(users: mockData)
    .storyStyle(footerStyle: .automatic.captionColor(.white))
```

For detailed guide please refer `StoryFooterStyle` documentation.

### Story Progress Bar

![Progress Bar](https://github.com/SimformSolutionsPvtLtd/SSStoryStatus/assets/147126103/ea8ca824-5bb5-4885-8dfc-23f994382fa6)

To customize progress bar of story you have to pass instance of `ProgressBarStyle`.

You can create new instance with custom values.
Alternatively, you can use available methods for specific customization.

```swift
SSStoryStatus(users: mockData)
    .storyStyle(progressBarStyle: .init(foreground: .linearGradient(colors: [.green, .orange], startPoint: .leading, endPoint: .trailing)))
```

For detailed guide please refer `ProgressBarStyle` documentation.

## Emoji

![Emoji](https://github.com/SimformSolutionsPvtLtd/SSStoryStatus/assets/147126103/33a31456-c9bc-44c0-9cb3-5d1c2fdd0bc2)

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

For detailed guide please refer `EmojiStyle` documentation.

## Message Field

![Message Field](https://github.com/SimformSolutionsPvtLtd/SSStoryStatus/assets/147126103/0d0597c4-9d47-4e33-9f80-62453cb9d820)

You can provide custom placeholder of type `Text` by passing to `messageField` view moodifier.

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

For detailed guide please refer `MessageStyle` documentation.
