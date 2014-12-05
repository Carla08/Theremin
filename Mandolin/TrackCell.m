//
//  TrackCell.m
//  Mandolin
//
//  Created by Apple on 05/12/14.
//  Copyright (c) 2014 Bellpipe. All rights reserved.
//

#import "TrackCell.h"
#import <FacebookSDK/FacebookSDK.h>
#import <FacebookSDK/FBGraphObject.h>

@interface TrackCell (){
    AVAudioPlayer *player;
    PlayVC *playVC;
}

@end
@implementation TrackCell


- (void)awakeFromNib {
    // Initialization code
    
    playVC= [[PlayVC alloc]init];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)play:(id)sender {
    
    NSLog(@"%@",self.track_name.text);
    NSString *filename = self.track_name.text;
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filepath = [documentsPath stringByAppendingPathComponent:filename];
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:filepath];

    NSURL *soundURL;
    
    if (fileExists)
    {
        soundURL = [NSURL fileURLWithPath:filepath isDirectory:NO];
    }
    NSLog(@"%@",soundURL);
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundURL error:nil];
    [player setDelegate:self];
    playVC.player=player;
    [player play];
    [playVC startProgress ];
}



- (IBAction)share:(id)sender {
    
    
    
}
- (void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    playVC.player=nil;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Done"message: @"Finish playing the recording!"delegate: nil cancelButtonTitle:@"OK"otherButtonTitles:nil];
    [alert show];
}
@end
