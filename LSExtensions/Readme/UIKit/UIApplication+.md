# Int Extensions

## appId
Value of property nameed of 'Itunes App Id' in Info.plist
- Requires: Property 'Itunes App Id' in Info.plist
- Note: this property is used in openReview(_: , completion: )

```swift
guard let appId = plist["Itunes App Id"] as? String else{
    assertOrToast("Please insert 'Itunes App Id' into Info.plist");
    return;
}
```

## displayName
Value of property named of 'CFBundleDisplayName' in Info.plist

```swift
let msg = "Please review if you like \(UIApplication.shared.displayName ?? "")"
```

## version
Value of property named of 'CFBundleShortVersionString' in Info.plist

```swift
versionLabel.text = "App Version: \(UIApplication.shared.version)"
```

## isVersion(lessThan: String, orSame: Bool = false)
return determine whether current application's version is less than given version or equal to it

```swift
let needToUpdate = UIApplication.shared.isVersion(lessThan: minVersion)
```

| Parameter | Type     | Description                                                                           |
| :-------- | :------- | :------------------------------------------------------------------------------------ |
| `version` | `string` | **Required**. version string to compare with version of current application           |
| `same`    | `bool`   | whether to return true if given verion string is equal to current application version |

## isVersion(largerThan: String, orSame: Bool = false)
return determine whether current application's version is larger than given version or equal to it

```swift
UIApplication.shared.isVersion(largerThan: minVersion)
```

| Parameter | Type     | Description                                                                           |
| :-------- | :------- | :------------------------------------------------------------------------------------ |
| `version` | `string` | **Required**. version string to compare with version of current application           |
| `same`    | `bool`   | whether to return true if given verion string is equal to current application version |

## carrier
carrier info of this device

```swift
if UIApplication.shared.carrier?.carrierName == ... {
    //
}
```

## isIPad
Is kind of Current Device iPad?

```swift
if UIApplication.shared.isIPad {
    //
}
```

## urlForItunes
Url for Itunes Link for this App

```swift
UIApplication.shared.open(UIApplication.shared.urlForItunes, ...);
```

## openItunes
Open AppStore for this App

```swift
UIApplication.shared.open(UIApplication.shared.urlForItunes, ...);
```

## openReview
Open Review Page for this App on AppStore

```swift
UIApplication.shared.openReview(appId){ result in
  //
};
```

| Parameter   | Type             | Description                                           |
| :---------- | :--------------- | :-----------------------------------------------------|
| `appId`     | `string`         | App ID for Review Page                                |
| `completion`| `bool` -> void   | block to call after opening review has been completed |

## openSettings
Opens Settings App page for this app

```swift
UIApplication.shared.openSettings{ result in
    //
};
```

| Parameter    | Type             | Description                                                 |
| :----------- | :--------------- | :-----------------------------------------------------------|
| `completion` | `bool` -> void   | block to call after opening Settings App has been completed |

## openTwitter
Open Page of specified User on Twitter App

```swift
UIApplication.shared.openTwitter(id) { url in
    //
}
```

| Parameter   | Type             | Description                                           |
| :---------- | :--------------- | :-----------------------------------------------------|
| `id`        | `string`         | Twitter Account Name                                  |
| `webOpen`   | `string` -> void | Handler to open url                                   |

## openFacebook
Open Page of specified User on Facebook App

```swift
UIApplication.shared.openFacebook(id) { url in
    //
}
```

| Parameter   | Type             | Description                                                               |
| :---------- | :--------------- | :-------------------------------------------------------------------------|
| `id`        | `string`         | FaceBook id converted number by [Find my Facebook ID](www.findmyfbid.com) |
| `webOpen`   | `string` -> void | Handler to open url                                                       |

## openInstagram
Open Page of specified User on Instagram App

```swift
UIApplication.shared.openInstagram(id) { url in
    //
}
```

| Parameter   | Type             | Description         |
| :---------- | :--------------- | :-------------------|
| `id`        | `string`         | Instagram Account   |
| `webOpen`   | `string` -> void | Handler to open url |

## openKakaoStory
Open Page Kakao Story of specified User on Kakao App

```swift
UIApplication.shared.openKakaoStory(id) { url in
    //
}
```

| Parameter   | Type             | Description              |
| :---------- | :--------------- | :------------------------|
| `id`        | `string`         | Kakao Story Account Name |
| `webOpen`   | `string` -> void | Handler to open url      |

## openKakaoPlus
Open Page Kakao Plus Friends of specified User on Kakao App

```swift
UIApplication.shared.openKakaoPlus(id) { url in
    //
}
```

| Parameter   | Type             | Description              |
| :---------- | :--------------- | :------------------------|
| `id`        | `string`         | Kakao Plus Account Name  |
| `webOpen`   | `string` -> void | Handler to open url      |

## openWeb
Open Safari with specified string as url

```swift
UIApplication.shared.openWeb("https://toyboy2.medium.com/")
```

| Parameter   | Type             | Description              |
| :---------- | :--------------- | :------------------------|
| `urlString` | `string`         | url to open with Safari  |

## openEmail
Open Mail App with specified email

```swift
UIApplication.shared.openEmail("your@email.com")
```

| Parameter   | Type             | Description                           |
| :---------- | :--------------- | :-------------------------------------|
| `email`     | `string`         | E-mail address to open with Mail App  |

## openSms
Open Message App with specified phone number

```swift
UIApplication.shared.openSms("+821000000000")
```

| Parameter   | Type             | Description                           |
| :---------- | :--------------- | :-------------------------------------|
| `sms`     | `string`           | Phone Number to open with Message App |

## openTel
Call to specified phone number

```swift
UIApplication.shared.openTel("+821000000000")
```

| Parameter   | Type             | Description          |
| :---------- | :--------------- | :--------------------|
| `phone`     | `string`         | Phone number to call |

## searchByGoogle
Open Web Browser(Safari) with Google Site to search by given keyboard

```swift
UIApplication.shared.searchByGoogle("toyboy2") { url in
    //
}
```

| Parameter   | Type             | Description                           |
| :---------- | :--------------- | :-------------------------------------|
| `keyword`   | `string`         | Keyword to search   |
| `webOpen`   | `string` -> Void | Handler to open url |

## searchByDaum
Open Web Browser(Safari) with Daum Site to search by given keyboard

```swift
UIApplication.shared.searchByGoogle("toyboy2") { url in
    //
}
```

| Parameter   | Type             | Description                           |
| :---------- | :--------------- | :-------------------------------------|
| `keyword`   | `string`         | Keyword to search   |
| `webOpen`   | `string` -> Void | Handler to open url |

## searchByNaver
Open Web Browser(Safari) with Naver Site to search by given keyboard

```swift
UIApplication.shared.searchByGoogle("toyboy2") { url in
    //
}
```

| Parameter   | Type             | Description                           |
| :---------- | :--------------- | :-------------------------------------|
| `keyword`   | `string`         | Keyword to search   |
| `webOpen`   | `string` -> Void | Handler to open url |

## onNetworking
Show Network Indicator asynchronously

```swift
UIApplication.shared.onNetworking()
```

## offNetworking
Hide Network Indicator asynchronously

```swift
UIApplication.shared.offNetworking()
```

## isForeground
Indication whether this application is on foreground

```swift
if UIApplication.shared.isForeground {
    //
}
```

## isBackground
Indication whether this application is in background

```swift
if UIApplication.shared.isForeground {
    //
}
```

## buildVersion
Value of property named of 'CFBundleVersionString' in Info.plist

```swift
if UIApplication.shared.buildVersion < latestVersion {
    //
}
```

## increaseBadgeNumber
Increases app icon badge number

```swift
UIApplication.shared.increaseBadgeNumber()
```

## decreaseBadgeNumber
Decrease app icon badge number

```swift
UIApplication.shared.decreaseBadgeNumber()
```

[Article](https://medium.com/@toyboy2/lsextensions-usage-int-b9ccdc058bb7)
