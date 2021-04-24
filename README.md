# Introduction

Ongoing work.

This projects provides a library to plot graphs with Vulkan, by using Flutter.

# Other doc

Not clear yet how to have good performance.
Flutter has 4 threads, and the doc on hybrid composition says it is don in the platform thread.
https://medium.com/flutterdevs/performance-monitoring-of-flutter-app-89698431473

Doc for embedding native views:
https://github.com/MagicPoulp/vulkan_charts_flutter

Here lies teh code change in Android 10 (it seems)
L259
https://github.com/flutter/engine/blob/f27729e97b5a00c3a8d8d49edc7b998fa755b97a/shell/platform/android/io/flutter/embedding/android/FlutterImageView.java

One person found another trick by making a FlutterView transparent and showing a GLSurface in an activity. I profiled his 2 repos with profile builds and android studio devs tools. However, this trick causes some Jerk in the DevTools. The AndroidView has no Jank. Moreover, this trick is not present in the doc. So it seems an old trick before optimizations were done (Android 10, Hybrid composition, etc).
https://github.com/t-artikov/flutter_two_surfaces_test

Doc for loading Vulkan from Android or Swift
https://github.com/MagicPoulp/display_vulkan_from_kotlin_or_swift/blob/master/README.md


