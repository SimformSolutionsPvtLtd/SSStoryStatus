# Customization

Customizing SSStoryStatus views.

## Overview

SSStoryStatus provides fully customizable UI components.

### Profile Listing

![Profile Listing](profile-listing)

To customize the profile listing you can use ``SwiftUI/View/profileListStyle(_:)`` view modifier.

For customizing profile view refer [Profile View](#profile-view).

```swift
SSStoryStatus(users: users)
    .profileListStyle(.automatic.horizontalSpacing(14))
```

You can use default style with ``ProfileListStyle/automatic`` and customize with available methods.
Alternatively, you can provide custom type that confirms to `ProfileListStyle` protocol.

Please refer ``ProfileListStyle`` documentation for more detail.

### Profile View

![Profile View](profile-view)

Profile views displayed in profile listed can be customized with the ``SwiftUI/View/profileStyle(_:)`` view modifier.

```swift
SSStoryStatus(users: users)
    .profileStyle(.automatic.profileSize(width: 80, height: 80))
```

You can use default style with ``ProfileStyle/automatic`` and customize with available methods.
Alternatively, you can provide custom type that confirms to ``ProfileStyle`` protocol.

Please refer ``ProfileStyle`` documentation for more detail.

### Story Styling

You ``SwiftUI/View/storyStyle(_:headerStyle:footerStyle:progressBarStyle:)`` view modifier to configure different components of story view.

To customize story like image story duration pass the instance of ``StoryStyle``.

You can create new instance with custom values.
Alternatively, you can use available methods for specific customization.

```swift
SSStoryStatus(users: mockData)
    .storyStyle(StoryStyle(storyDuration: 15))
```

#### Story Header

![Story Header](story-header)

To customize story header you can pass type confirming to ``StoryHeaderStyle`` protocol.

You can use built-in type with ``StoryHeaderStyle/automatic`` with available customization methods.
Alternatively, you can provide custom type that confirms to ``StoryHeaderStyle`` protocol.

```swift
SSStoryStatus(users: mockData)
    .storyStyle(headerStyle: .automatic.dismissColor(.gray))
```

For detailed guide please refer ``StoryHeaderStyle`` documentation.

#### Story Footer

![Story Footer](story-footer)

To customize story footer you can pass type confirming to ``StoryFooterStyle`` protocol.

You can use built-in type with ``StoryFooterStyle/automatic`` with available customization methods.
Alternatively, you can provide custom type that confirms to ``StoryFooterStyle`` protocol.

```swift
SSStoryStatus(users: mockData)
    .storyStyle(footerStyle: .automatic.captionColor(.white))
```

For detailed guide please refer ``StoryFooterStyle`` documentation.

#### Story Progress Bar

![Progress Bar](progress-bar)

To customize progress bar of story you have to pass instance of ``ProgressBarStyle``.

You can create new instance with custom values.
Alternatively, you can use available methods for specific customization.

```swift
SSStoryStatus(users: mockData)
    .storyStyle(progressBarStyle: .init(foreground: .linearGradient(colors: [.green, .orange], startPoint: .leading, endPoint: .trailing)))
```

For detailed guide please refer ``ProgressBarStyle`` documentation.

### Emoji

![Emoji](emoji)

You can use custom emoji reactions by providing list of emojis  in ``SwiftUI/View/emoji(_:style:isEnabled:onSelect:)`` modifiers.

```swift
SSStoryStatus(users: mockData)
    .emoji(["🪄", "🧙🏼‍♂️", "🔮", "🧚", "🦉"]) { emoji, _, _ in
        print("Selected - ", emoji)
    }
```

You can style the emoji view by providing a type confirming to ``EmojiStyle`` protocol to ``SwiftUI/View/emoji(_:style:isEnabled:onSelect:)`` or ``SwiftUI/View/emojiStyle(_:)`` view modifier.

You can use built-in type with ``EmojiStyle/automatic`` with available customization methods.
Alternatively, you can provide custom type that confirms to ``EmojiStyle`` protocol.

```swift
SSStoryStatus(users: mockData)
    .emojiStyle(.automatic(emojiSize: 20))
```

To enable or disable emoji view you can pass boolean value to `emoji` view modifier.

```swift
SSStoryStatus(users: mockData)
    .emoji(isEnabled: false)
```

For detailed guide please refer ``EmojiStyle`` documentation.

### Message Field

![Message Field](message-field)

You can provide custom placeholder of type `Text` by passing to ``SwiftUI/View/messageField(placeholder:style:onSend:)`` view moodifier.

```swift
SSStoryStatus(users: mockData)
    .messageField(placeholder: Text("Type something...")) { message, _, _ in
        print("Send - ", message)
    }
```

You can style the message field view by providing a type confirming to ``MessageStyle`` protocol to ``SwiftUI/View/messageField(placeholder:style:onSend:)`` or ``SwiftUI/View/messageStyle(_:)`` view modifier.

You can use built-in type with ``MessageStyle/automatic`` with available customization methods.
Alternatively, you can provide custom type that confirms to ``MessageStyle`` protocol.

```swift
SSStoryStatus(users: mockData)
    .messageStyle(.automatic(messageColor: .white))
```

For detailed guide please refer ``MessageStyle`` documentation.

## Image Cache

There are two default implementations available ``ImageCache/storage`` and ``ImageCache/nscache``.

NSImageCache cache images into NSCache. Cache will be cleared each time application is closed.

StorageImageCache stores the cached images into file system. Cache can be cleared by passing date object to cacheExpire parameter in init(users:sorted:cacheExpire:).

You can also provide custom implementation of ImageCache by confirming to `ImageCache` protocol.

To change image cache use ``SSStoryStatus/changeImageCache(_:)`` 

```swift
SSStoryStatus(users: mockData)
    .changeImageCache(.nscache)
```
