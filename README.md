# Introduction

This project was started in the name of the international green day. Because Vulkan can save batteries.

This projects provides a library to plot graphs with Vulkan, by using Flutter.

Ongoing work. First focus on Android. But it should be able to work later on iOS.

# Licences

See the LICENCE file and the licences folder.

# Contribution

Any one can suggest a PR. But we do not change the LICENSE. Please just add your name in the other_contributors file. And make sure you configure github to hide your email in the commit.

# Status

Trying to find a way to combine flutter with vulker from a native app, using FLutter for most of the app.

See the choice of technique below. I will try a FlutterView, and I will use the pixel shader discard for the transparency. Doing this at a low level probably removes lots of overhead. Main reason for using a FlutterView: to transfer data between the Flutter code and the SurfaceView. It is simpler and faster within the same activity.


# Why embed flutter and not embed native

Because the doc says that there will always be performance problems embedding inside flutter (see the performance section i nthe Main link called add-to-app). In short only android can use a texture that takes memory and graphics performance. Both iOs and Android have Hybrid Composition. But it make the Platform Thread of Flutter manage the rendering and it can stall the other things like OS and plugin messages.

But we can embed flutter inside a native app.

# Choice of technique

Main reason for using a FlutterView: to transfer data between the Flutter code and the SurfaceView. It is simpler and faster wihtin the same activity.

There are 3 ways, activity, fragment, view.
https://flutter.dev/docs/development/add-to-app/android/project-setup

Requirements:
We want to have 2 superposed fullscreens.
The app must be scrollable vertically.
We should be able to put the SurfaceView with Vulkan on top, with transparent background.

FlutterActivity
t-artikov found a strange bug when tapping the activity. Moving back, the FlutterActivity is doubled.
Maybe there is a blank screen when switching between activities (unkown).
To transfer data between activites, it is inelegant to have to use a global object such as the Application object. And putExtra only works for basic data at the start of an activity.
Intuitively, it seems that activity are intended to decouple separate things both visually and in the data.

FlutterFragment, a FragmentActivity
There is no satisfying way to overlay a Fragment with the rest. It looks like a hack to have to use a dialog mode. There seems to be some startup work that takes time and that we have to wait for.
It does not seem that a Fragment was made to be fullscreen with use of overlays.

FlutterView
Advanced, but seems very fined tuneable in the details.
It seems to me clear taht the transfer of data will be much more efficient and simpler within the same activity.

Isolated ideas:
It seems we can put transparency on a pixel directly in the fragment shader using discard.
https://stackoverflow.com/questions/49333647/vulkan-support-alpha-channel-for-sprites
A SurfaceView has a function to put it on top, and has a transparency mode (but what if vulkan has put a color already that is not transparent?).
To superpose views, we can use RelativeLayout, or we can also use a getOverlay() and set an overlay (exact superposition).

About SurfaceView

A SurfaceView has fundamental bug. But it does not happen each time and there seems to exist a workaround.
https://issuetracker.google.com/issues/72624889
https://github.com/t-artikov/surface-view-bug

One guy has a workaround in the issue tracker
"To workaround, you can try disabling the next transition, e.g., overridePendingTransition(0,0) when the next Activity starts. Worked for me."

I found that a SurfaceView has fundamental limitations. Maybe that is why the show other apps effect is not synched.
You could try a texture. However, a texture is said to have lower performance.

It has limitations in how it is synchronized
https://flutter.dev/docs/development/add-to-app/android/add-flutter-fragment
"FlutterFragment can either use a SurfaceView to render its Flutter content, or it can use a TextureView. The default is SurfaceView, which is significantly better for performance than TextureView. However, SurfaceView can’t be interleaved in the middle of an Android View hierarchy. A SurfaceView must either be the bottommost View in the hierarchy, or the topmost View in the hierarchy. Additionally, on Android versions before Android N, SurfaceViews can’t be animated because their layout and rendering aren’t synchronized with the rest of the View hierarchy. If either of these use cases are requirements for your app, then you need to use TextureView instead of SurfaceView. Select a TextureView by building a FlutterFragment with a texture RenderMode:"

# Known bugs

t-artikov found a critical bug with surface views on pure android.
However, it seems that modern android and powerful devices do not have this problem.
And the emulator is never really reliable. No Device on Android 10 was found with a bug yet.
https://github.com/flutter/flutter/issues/53989
https://github.com/t-artikov/flutter_transparent_surface_test
https://github.com/t-artikov/surface-view-bug
However, I do not agree that the SurfaceView bug is exactly the same as the FlutterActivity bug. Because we have FlutterActivity extends Activity in the Java code.

# Main links

To embed flutter inside a native app:
https://flutter.dev/docs/development/add-to-app

Doc to use a FlutterView
https://flutter.dev/docs/development/add-to-app

Code sample to use a FlutterView
https://github.com/flutter/samples.git
add_to_app/fullscreen/android_fullscreen

# Other links

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

Code sample fromthe official doc for loading a FlutterView on Android
https://github.com/flutter/samples/tree/master/add_to_app/android_view

# How to run espresso tests

cd fullscreen/android_fullscreen
`pwd`/../flutter_module/.android/gradlew app:connectedAndroidTest -Ptarget=`pwd`/../flutter_module/test_driver/example.dart
