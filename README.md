# Introduction

Ongoing work.

This projects provides a library to plot graphs with Vulkan, by using Flutter.

# Other doc

Doc for embedding native views:
https://github.com/MagicPoulp/vulkan_charts_flutter

One person found another trick by making a FlutterView transparent and showing a GLSurface in an activity. I profiled his 2 repos with profile builds and android studio devs tools. However, this trick causes some Jerk in the DevTools. The AndroidView has no Jank. Moreover, this trick is not present in the doc. So it seems an old trick before optimizations were done (Android 10, Hybrid composition, etc).
https://github.com/t-artikov/flutter_two_surfaces_test

Doc for loading Vulkan from Android or Swift
https://github.com/MagicPoulp/display_vulkan_from_kotlin_or_swift/blob/master/README.md


