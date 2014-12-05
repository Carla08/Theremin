//
//  ViewController.m
//  Mandolin
//
//  Created by Ariel Elkin on 28/12/2013.
//
//  Copyright (c) 2013 Bellpipe. All rights reserved.
//
//Modified by Carla Prieto and Mario Contreras on 23/11/2014
//Theremin
//Note this ViewController is wrote on Obejective-C++.


//Basic Imports:
#import "ViewController.h"
#import "AppDelegate.h"
//Core Motion:
#import <CoreMotion/CoreMotion.h>
//Amazing audio engine and STK instrument (BeeThree) and AVFoundation for recording.
#import "BeeThree.h"
#import "AEBlockChannel.h"
#import <AVFoundation/AVFoundation.h>

#define degrees(x) (180*x/M_PI)
// PARA DOS ESCALAS: #define frequency(x) (2.074666*x +261.62)
// PARA UNA ESCALA:
#define frequency(x) (1.037333*x +261.62)

@implementation ViewController {
    //Set Amazing Audio engine and STK's BeeThree and AVFoundation recorder:
    AEBlockChannel *myBeeThreeChannel;
    stk::BeeThree *myBeeThree;
      AVAudioRecorder *recorder;
    //Declaring Motion Manager:
    CMMotionManager *manager;
    
    /**Outlets (Debugging purpuses):
    IBOutlet UISlider *slider;//changes frecuency
    IBOutlet UILabel *x_acc;//Indicator
    IBOutlet UILabel *y_acc;//Indicator **/
    IBOutlet UILabel *z_acc;//Indicator
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //Amazing Audio and STK Setup:
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];

    NSError *errorAudioSetup = NULL;
    BOOL result = [[appDelegate audioController] start:&errorAudioSetup];
    if ( !result ) {
        NSLog(@"Error starting audio engine: %@", errorAudioSetup.localizedDescription);
    }

    stk::Stk::setRawwavePath([[[NSBundle mainBundle] pathForResource:@"rawwaves" ofType:@"bundle"] UTF8String]);
    
    myBeeThree = new stk::BeeThree();
    myBeeThree->setFrequency(400);
    
    myBeeThreeChannel = [AEBlockChannel channelWithBlock:^(const AudioTimeStamp  *time,
                                                           UInt32 frames,
                                                           AudioBufferList *audio) {
        for ( int i=0; i<frames; i++ ) {
            
            ((float*)audio->mBuffers[0].mData)[i] =
            ((float*)audio->mBuffers[1].mData)[i] = myBeeThree->tick();
            
        }
    }];
    
    [[appDelegate audioController] addChannels:@[myBeeThreeChannel]];
    
    //Motion Manager set up:
    manager = [[CMMotionManager alloc] init];
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(getValues:) userInfo:nil repeats:YES];
    manager.deviceMotionUpdateInterval = 0.05; // 20 Hz
    [manager startDeviceMotionUpdates];
    
    
    //AVFoundation Recorder Set Up:
    NSArray *pathComponents = [NSArray arrayWithObjects:
                               [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject],
                               @"MyAudioMemo.m4a",
                               nil];
    NSURL *outputFileURL = [NSURL fileURLWithPathComponents:pathComponents];
    
    // Setup audio session
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    
    // Define the recorder setting
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc] init];
    
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    [recordSetting setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
    [recordSetting setValue:[NSNumber numberWithInt: 2] forKey:AVNumberOfChannelsKey];
    
    // Initiate and prepare the recorder
    recorder = [[AVAudioRecorder alloc] initWithURL:outputFileURL settings:recordSetting error:NULL];
    recorder.delegate = self;
    recorder.meteringEnabled = YES;
    [recorder prepareToRecord];
    recording=false;
}
//Motion Manager callback for polling acc data:
-(void) getValues:(NSTimer *) timer {
  //OUTLETS OF DEBBUG
   /** x_acc.text = [NSString stringWithFormat:@"%.2f",degrees(manager.deviceMotion.attitude.pitch)];
    y_acc.text = [NSString stringWithFormat:@"%.2f",degrees(manager.deviceMotion.attitude.yaw)];**/
    z_acc.text = [NSString stringWithFormat:@"%.2f",degrees(manager.deviceMotion.attitude.roll)];
    [self ChangeNote:frequency(degrees(manager.deviceMotion.attitude.roll))];
}

/*- (IBAction)changeFrequency:(UISlider *)sender {
    myBeeThree->setFrequency(sender.value);
}*/

-(void)ChangeNote: (float)freq  {
    myBeeThree->setFrequency(freq);
}

- (IBAction)PlayTheremin:(id)sender {
    myBeeThree->noteOn(0, 0.5);
}
- (IBAction)StopTheremin:(id)sender {
    myBeeThree->noteOff(0.5);
}
- (IBAction)Record:(id)sender {
    if ((!recorder.recording)&&(recording==false)) {
        recording=true;
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setActive:YES error:nil];
        
        // Start recording
        [recorder record];
        
    } else {
        
        // Pause recording
        [recorder stop];
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        [audioSession setActive:NO error:nil];
        recording=false;
    }
}
- (void) audioRecorderDidFinishRecording:(AVAudioRecorder *)avrecorder successfully:(BOOL)flag{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Done" message: @"Name your masterpiece:" delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

@end
