# Customizing SSStoryStatus

## Profile Listing

To customize the profile listing you can use `profileListStyle` view modifier.

For customizing profile view refer [Profile View](#profile-view).

```swift
SSStoryStatus(users: users)
    .profileListStyle(.automatic.horizontalSpacing(14))
```

You can use default style with `ProfileListStyle.automatic` and customize with available methods.
Alternatively, you can provide custom type that confirms to `ProfileListStyle` protocol.

Please refer `ProfileListStyle` documantation for more detail.

## Profile View

Profile views displayed in profile listed can be customized with the `profileStyle` view modifier.

```swift
SSStoryStatus(users: users)
    .profileStyle(.automatic.profileSize(width: 80, height: 80))
```

You can use default style with `ProfileStyle.automatic` and customize with available methods.
Alternatively, you can provide custom type that confirms to `ProfileStyle` protocol.

Please refer `ProfileStyle` documantation for more detail.

## Story Styling

You `storyStyle` view modifier to configure different components of story view.

### Story Header

To customize story header you can pass type confirming to `StoryHeaderStyle` protocol.

You can use built-in type with `StoryHeaderStyle.automatic` with available customization methods.
Alternatively, you can provide custom type that confirms to `StoryHeaderStyle` protocol.

```swift
SSStoryStatus(users: mockData)
    .storyStyle(headerStyle: .automatic.dismissColor(.gray))
```

For detailed guide please refer `StoryHeaderStyle` documantation.

### Story Footer

To customize story footer you can pass type confirming to `StoryFooterStyle` protocol.

You can use built-in type with `StoryFooterStyle.automatic` with available customization methods.
Alternatively, you can provide custom type that confirms to `StoryFooterStyle` protocol.

```swift
SSStoryStatus(users: mockData)
    .storyStyle(footerStyle: .automatic.captionColor(.white))
```

For detailed guide please refer `StoryFooterStyle` documantation.

### Story Progress Bar

To customize progress bar of story you have to pass instance of `ProgressBarStyle`.

You can create new instance with custom values.
Alternatively, you can use available methods for specific customization.

```swift
SSStoryStatus(users: mockData)
    .storyStyle(progressBarStyle: .init(foreground: .linearGradient(colors: [.green, .orange], startPoint: .leading, endPoint: .trailing)))
```

For detailed guide please refer `ProgressBarStyle` documantation.

## Emoji

You can use custom emoji reactions by providing list of emojis  in `emoji` modifiers.

```swift
SSStoryStatus(users: mockData)
    .emoji(["😂", "🔥", "😭", "😍", "😡"]) { emoji, _, _ in
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

For detailed guide please refer `EmojiStyle` documantation.

## Messsage Field

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

For detailed guide please refer `MessageStyle` documantation.
