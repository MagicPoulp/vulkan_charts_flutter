# Introduction

This project was started in the name of the international green day. Because Vulkan can save batteries.

This projects provides a library to plot graphs with Vulkan, by using Flutter.

Ongoing work.

# Licences

See the LICENCE file and the licences folder

# Status

Trying to find a way to combine flutter with vulker from a native app, using FLutter for most of the app.

# Why embed flutter and not embed native

Because the doc says that there will always be performance problems embedding inside flutter (see teh performance section i nthe Main link called add-to-app).

But we can embed flutter inside a native app.

# known bugs

t-artikov found a critical bug with surface views on pure android.
However, it seems that modern android and powerful devices do not have this problem.
And the emulator is never really reliable. No Device on andorid 10 was found with a bug yet.
https://github.com/flutter/flutter/issues/53989

# Links

Main link to embed flutter inside a native app:
https://flutter.dev/docs/development/add-to-app

Doc for embedding native views inside Flutter:
https://flutter.dev/docs/development/platform-integration/platform-views?tab=ios-platform-views-swift-tab

Not clear yet how to have good performance.
Flutter has 4 threads, and the doc on hybrid composition says it is don in the platform thread.
https://medium.com/flutterdevs/performance-monitoring-of-flutter-app-89698431473

Here lies the code change in Android 10 (it seems)
L259
https://github.com/flutter/engine/blob/f27729e97b5a00c3a8d8d49edc7b998fa755b97a/shell/platform/android/io/flutter/embedding/android/FlutterImageView.java

One person found another trick by making a FlutterView transparent and showing a GLSurface in an activity. I profiled his 2 repos with profile builds and android studio devs tools. However, this trick causes some Jerk in the DevTools. The AndroidView has no Jank. Moreover, this trick is not present in the doc. So it seems an old trick before optimizations were done (Android 10, Hybrid composition, etc).
https://github.com/t-artikov/flutter_two_surfaces_test

Doc for loading Vulkan from Android or Swift
https://github.com/MagicPoulp/display_vulkan_from_kotlin_or_swift/blob/master/README.md


