//
//  ViewController.h
//  Mandolin
//
//  Created by Ariel Elkin on 28/12/2013.
//  Copyright (c) 2013 Bellpipe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "PlayVC.h"

@interface ViewController : UIViewController <AVAudioRecorderDelegate, UIAlertViewDelegate>{
    BOOL recording;
    NSMutableArray *tracks;
}
@end
