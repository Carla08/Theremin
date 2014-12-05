//
//  PlayVC.h
//  Mandolin
//
//  Created by Apple on 05/12/14.
//  Copyright (c) 2014 Bellpipe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface PlayVC : UIViewController <AVAudioRecorderDelegate, AVAudioPlayerDelegate,UITableViewDataSource, UITableViewDelegate>{
    
    IBOutlet UITableView *TableView;
}

@property NSURL *songUrl;
@property NSMutableArray *tracks;
- (IBAction)PlaySong:(id)sender;
- (IBAction)backToListVC:(id)sender;

@end
