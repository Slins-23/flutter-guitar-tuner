**Warning:** *Currently works only on Android! This application uses a custom-made plugin (which I named "flutter_fft"), which makes use of platform channels. Platform channels are means for you to call native platform code (Java -> Android | Objective-C/Swift -> iOS) and integrate them with Flutter. I have made and tested this plugin only in Java, in other words, on Android. Key functionalities rely on the platform channel, such as audio capturing from the microphone*

# Flutter Guitar Tuner

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

* I made some changes to Flutter's default widget "stepper.dart" at /flutter/packages/flutter/lib/src/material/stepper.dart - If you want to rebuild the code you will need to replace the original file with the one found in this repository, at this repository: "intricacies/flutter-widgets/stepper.dart"

## Features

Features that have been implemented and features that have yet to be implemented.

### Implemented

#### Tuner

The main functionality of the application.
It was tricky to come up with it, since Flutter does not provide support for some device capabilities, one of them being the microphone, which obviously is the most important piece.

After some research, I still couldn't find exactly what I needed, so I started to look into platform channels, which is what I ended up going with, since some plugins I found were outdated, and Flutter doesn't have great support for this, as I mentioned.

In order to not extend myself here (if you want to find out exactly how the plugin works, you can check it out at https://github.com/slins-23/flutter_fft), basically I built the platform channel storing the microphone stream and performed the pitch detection using the "TarsosDSP" Java library (https://github.com/JorenSix/TarsosDSP), which is a very nice library for audio processing.

For specifics about the data to be detected, check the "Settings" implementation below.
  
#### Settings

A relatively simple settings widget, which just like this app (at the moment), is still pretty simple, in its early stages, functional and intuitive - but not "pretty".

#### Contents

1. ##### Tuning Picker
 
    Select the tuning target.

2. ##### Custom Tuning

    Lets you create your own tuning target, which creates a new entry in the tuning picker.

3. ##### Interval

    Interval in which the plugin's detection API gets called.

4. ##### Tolerance

    How far apart can the current frequency and the target/in-tune frequency be in order to be considered "On Pitch".

6. ##### Sample Rate

    Sample rate to be processed.

7. ##### Channels

    Number of channels to be processed.

8. ##### Theme Changer

    Simple theme switch, Ligth/Dark only currently.

9. ##### Help

    Just some boilerplate "help" dialog for whenever I put it to use.

10. ##### Reset

    Resets all the settings to default.

### Yet to implement

#### iOS Version/Platform Channel

Although flutter only has one dart codebase, I made my own custom plugin for this application, which uses a platform channel. 
Platform channels are programmed in native code. Since I only made the Java/Android version, the app has no functionality on iOS and does NOT work, as I still have to make the Objective-C/Swift version.
Will implement this whenever I get back to this project.

#### String-by-string Tuner

String-by-string version of the tuner. Currently only implemented one tuner, which is chromatic.

#### Metronome

Make a metronome.

## Bugs to fix

1. Make a proper testing system;
2. When it's the first time the app is opened in the user's device, it does not start recording straight away, needing a restart to properly work;
3. The settings that have both a slider and text fields as inputs are incosistent with each other;
4. App randomly closes sometimes on the Android Emulator (haven't encountered this issue on the actual Android device);
5. 
