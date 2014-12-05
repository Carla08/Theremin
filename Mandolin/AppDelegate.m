//
//  AppDelegate.m
//  Mandolin
//
//  Created by Ariel Elkin on 28/12/2013.
//  Copyright (c) 2013 Bellpipe. All rights reserved.
//

#import "AppDelegate.h"
#import "AEAudioController.h"
#import <FacebookSDK/FacebookSDK.h>

@interface AppDelegate()

@property (nonatomic) AEAudioController *audioController;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.audioController = [[AEAudioController alloc]
                            initWithAudioDescription:[AEAudioController nonInterleavedFloatStereoAudioDescription]
                            inputEnabled:NO];
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    // Logs 'install' and 'app activate' App Events.
    [FBAppEvents activateApp];
}

@end
