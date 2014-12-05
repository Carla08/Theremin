//
//  TrackCell.h
//  Mandolin
//
//  Created by Apple on 05/12/14.
//  Copyright (c) 2014 Bellpipe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "PlayVC.h"
#import <FacebookSDK/FacebookSDK.h>

@interface TrackCell : UITableViewCell <AVAudioPlayerDelegate>
@property (strong, nonatomic) NSURL *track;
@property (strong, nonatomic) IBOutlet UILabel *track_name;
- (IBAction)play:(id)sender;
- (IBAction)share:(id)sender;



@end
