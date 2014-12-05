//
//  PlayVC.m
//  Mandolin
//
//  Created by Apple on 05/12/14.
//  Copyright (c) 2014 Bellpipe. All rights reserved.
//

#import "PlayVC.h"

@interface PlayVC (){
    AVAudioPlayer *player;
}

@end

@implementation PlayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  //  [self.tableView registerNib:[UINib nibWithNibName:@"TrackCell" bundle:nil ] forCellReuseIdentifier:@"TrackCellType"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)PlaySong:(id)sender {
    
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:_songUrl error:nil];
    NSLog(@"%@",self.songUrl);
    [player setDelegate:self];
    [player play];
}

- (IBAction)backToListVC:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Done"message: @"Finish playing the recording!"delegate: nil cancelButtonTitle:@"OK"otherButtonTitles:nil];
    [alert show];
}
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tracks count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //UITableViewCell *cell = [[UITableViewCell alloc] init];
    TrackCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TrackCellType" forIndexPath:indexPath];
    cell.track_name.text = [self.tracks objectAtIndex:indexPath.row];
    return cell;
}
@end
