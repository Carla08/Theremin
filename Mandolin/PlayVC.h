//
//  PlayVC.h
//  Mandolin
//
//  Created by Apple on 05/12/14.
//  Copyright (c) 2014 Bellpipe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "TrackCell.h"

@interface PlayVC : UIViewController <AVAudioRecorderDelegate, AVAudioPlayerDelegate,UITableViewDataSource, UITableViewDelegate>{
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property NSURL *songUrl;
@property NSMutableArray *tracks;
- (IBAction)PlaySong:(id)sender;
- (IBAction)backToListVC:(id)sender;

@end
