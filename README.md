# Flutter Guitar Tuner

**Warning:** *Currently works only on Android! This application uses a custom-made plugin (which I named "flutter_fft"), which makes use of platform channels. Platform channels are means for you to call native platform code (Java -> Android | Objective-C/Swift -> iOS) and integrate them with Flutter. I have made and tested this plugin only in Java, in other words, on Android. Key functionalities rely on the platform channel, such as audio capturing from the microphone*

**The app was developed and tested in a Pixel 2 emulator, API 29. Does not work on iOS at the moment due to the platform channel having yet to be implemented.**

**Flutter project has to be created using Java & Objective-C**

<img src="https://i.imgur.com/DE07Jkq.png" width="250">

My first (and currently only) Flutter project.

When I started this project, I had just recently bought my first guitar.

About a week into learning about music theory and the guitar itself, I was looking for some apps that could perhaps help me in the learning process, specifically an application that had what, in my eyes, I needed at the time.

Not that it was really necessary, but there were a couple of things I wanted that I couldn't find in a single app, even though I could find "parts" of what I wanted in some of the apps.

Since it had been a while from the last time I had a personal project, why not now, right?

The plan was basically to have an application that, as I said, has things I find useful and could help me in the learning process. For this, the app should have one fundamental piece, which is the "tuner".

Even though many apps have tuners, I felt like there were some things I liked and disliked about some apps.
If I made my own app, I could implement "the best" of both worlds, without the need to, perhaps, go to another app just to make use of one functionality, then go back to another one... 

It would be much more handy to just have them in one single app, and it would save some storage space as well.

Another reason is the bloatware and ADS in the application, which won't be in my own application, obviously.

I took that as an opportunity to program my first mobile application, specifically an android application at the moment, and learn Flutter/Dart in the process, which is something I have had in my mind for a couple of months.

* I made some changes to Flutter's default widget "stepper.dart" at /flutter/packages/flutter/lib/src/material/stepper.dart - If you want to rebuild the app, you will need to replace the original file with the one found in this repository, at this folder: "intricacies/flutter-widgets/stepper.dart"

## Features

Features that have been implemented and features that have yet to be implemented.

### Implemented

#### Tuner

<img src="https://i.imgur.com/9vec5HW.png" width="250">
<img src="https://i.imgur.com/dLdB5BL.png" width="250">
<img src="https://i.imgur.com/y2C5Cy8.png" width="250">

The main functionality of the application.
It was tricky to come up with it, since Flutter does not provide support for some device capabilities, one of them being the microphone, which obviously is the most important piece.

After some research, I still couldn't find exactly what I needed, so I started to look into platform channels, which is what I ended up going with, since some plugins I found were outdated, and Flutter doesn't have great support for this, as I mentioned.

In order to not extend myself here (if you want to find out exactly how the plugin works, you can check it out at https://github.com/slins-23/flutter-fft, and get it at ### Plugin at pub-dev
https://pub.dev/packages/flutter_fft. 
Basically I built the platform channel storing the microphone stream and performed the pitch detection using the "TarsosDSP" Java library (https://github.com/JorenSix/TarsosDSP), which is a very nice library for audio processing.

For specifics about the data to be detected, check the "Settings" implementation below.
  
#### Settings

<img src="https://i.imgur.com/2lyIydh.png" width="250">

A relatively simple settings widget, which just like this app (at the moment), is still pretty simple, in its early stages, functional and intuitive - but not "pretty".

#### Contents

1. ##### Tuning Picker
 
    Select the tuning target.

2. ##### Custom Tuning

    <img src="https://i.imgur.com/hUxWYRv.png" width="250">
    <img src="https://i.imgur.com/M6NGFeN.png" width="250">

    Lets you create your own tuning target, which creates a new entry in the tuning picker.

3. ##### Interval

    Interval in which the plugin's detection API gets called.

4. ##### Tolerance

    How far apart can the current frequency and the target/in-tune frequency be in order to be considered "On Pitch".

5. ##### Sample Rate

    Sample rate to be processed.

6. ##### Channels

    Number of channels to be processed.

7. ##### Theme Changer

    Simple theme switch, Ligth/Dark only currently.

8. ##### Help

    Just some boilerplate "help" dialog for whenever I put it to use.

9. ##### Reset

    Resets all the settings to default.

### Yet to implement

1. Make a pretty UI, animations, improve usability

The app is currently very raw, although usable. (Hence why I uploaded it, as it stands usable, and probably useful for someone else provided they intend to make something similar to this, by using this as a reference)

2. iOS Version/Platform Channel

Although flutter only has one dart codebase, I made my own custom plugin for this application, which uses a platform channel.

Platform channels are programmed in native code. Since I only made the Java/Android version, the app has no functionality on iOS and does NOT work, as I still have to make the Objective-C/Swift version.
Will implement this whenever I get back to this project.

3. Web and desktop versions

Make web and desktop versions of the applications.

4. Rust + WebAssembly + Native JavaScript mobile framework

Possibly learn Rust, WebAssembly and a JS mobile framework, such as React Native / Vue Native to recreate the application.

I find Flutter not very flexible and pretty restrictive in its current state. I also dislike its widget system, since it's extremely hard on the eyes, not very readable due to too much identation/nesting. State management is also quite confusing.

It's not easy to make a very customized application with Flutter.

That's where JavaScript would play its part, due to not being nearly as restrictive as Flutter, having more libraries for animation, community support, etc.

Rust (or C++) would play its part in the backend, handling all the processing for the pitch detection behind the scenes.

Not only would this application be very flexible, but very portable as well.

5. String-by-string Tuner

String-by-string version of the tuner. Currently only implemented one tuner, which is chromatic.

6. Add more default tuning options

The only tuning options currently are the standard tuning and a testing tuning.

7. Make my own pitch detector and improve algorithm speed

Currently using an implementation from the "TarsosDSP" Java library, where there could be performance gains in many ways.

8. Metronome

Make a metronome.

9. Improve theming and add custom-made user themes

Allow users to create their own themes.

## Bugs to fix

1. The settings that have both a slider and text fields as inputs are incosistent with each other;
2. Haven't tested other emulators/devices for possible rendering and positioning issues, as well as hardware limitations
3. Font doesn't render octaves greater than 4;
4. When adding a new tuning containing too many strings/big letters, the dropdown button overflows;
5. Faded settings sliders;
6. Tuning target text;
7. Stepper buttons background color;
8. Native stepper customization, currently relies on modifying a base Flutter dart file