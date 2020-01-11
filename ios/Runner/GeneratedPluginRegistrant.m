//
//  Generated file. Do not edit.
//

#import "GeneratedPluginRegistrant.h"

#if __has_include(<firebase_admob/FLTFirebaseAdMobPlugin.h>)
#import <firebase_admob/FLTFirebaseAdMobPlugin.h>
#else
@import firebase_admob;
#endif

#if __has_include(<flutter_fft/FlutterFftPlugin.h>)
#import <flutter_fft/FlutterFftPlugin.h>
#else
@import flutter_fft;
#endif

#if __has_include(<shared_preferences/FLTSharedPreferencesPlugin.h>)
#import <shared_preferences/FLTSharedPreferencesPlugin.h>
#else
@import shared_preferences;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [FLTFirebaseAdMobPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTFirebaseAdMobPlugin"]];
  [FlutterFftPlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterFftPlugin"]];
  [FLTSharedPreferencesPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTSharedPreferencesPlugin"]];
}

@end
