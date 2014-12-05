#import "ShowsTableViewController.h"
#import "DetailShowViewController.h"
#import "VideoCell.h"
#import "ParseJSON.h"
#import "YoutubeVideo.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"

@interface ShowsTableViewController (){
    NSArray *videoList;
    NSDictionary *films;
}

@end

@implementation ShowsTableViewController

#pragma mark - System

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getListOfVideos];
    
}

-(void)getListOfVideos{
    NSString *baseDomain = @"https://gdata.youtube.com/feeds/api/videos";
    NSString *maxresults = @"50";
    NSString *orderBy = @"published";
    //NSString *author = @"sevillafilmfest";
    NSString *author = @"nba";
    NSString *extension = @"v=2&alt=jsonc";
    NSString *urlYoutube = [NSString stringWithFormat:@"%@?max-results=%@&orderby=%@&author=%@&%@",
                            baseDomain,maxresults,orderBy,author,extension];
    
    
    NSDictionary *listOfVideos = [ParseJSON listOfVideos:urlYoutube];
    int videoListSize = [[[listOfVideos valueForKey:@"data"] valueForKey:@"totalItems"]  intValue];
    if (videoListSize>0) {
        NSMutableArray *youtubeVideoList = [[NSMutableArray alloc] init];
        NSArray *arrayVideoList = [[listOfVideos valueForKey:@"data"] valueForKey:@"items"];
        for (NSDictionary *videoDictionary in arrayVideoList) {
            NSString *idVideo = [videoDictionary valueForKey:@"id"];
            NSString *description = [videoDictionary valueForKey:@"description"];
            //NSString *updated = [videoDictionary valueForKey:@"updated"];
            
            NSString *departTimeDate = [videoDictionary valueForKey:@"updated"];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
            NSDate *date = [dateFormatter dateFromString:departTimeDate];
            
            NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
            NSInteger day = [components day];
            NSInteger month = [components month];
            NSInteger year = [components year];
            
            NSString *updated = [NSString stringWithFormat:@"%ld-%ld-%ld",(long)day,(long)month,(long)year];
            
            NSString *duration = [videoDictionary valueForKey:@"duration"];
            NSString *title = [videoDictionary valueForKey:@"title"];
            
            // If we are using wifi, take hqDefault
            NSString *thumbnail = [[videoDictionary valueForKey:@"thumbnail"] valueForKey:@"hqDefault"];
            YoutubeVideo *video = [[YoutubeVideo alloc] initWithId:idVideo withDescription:description withUpdated:updated withDuration:duration withTitle:title withThumbnail:thumbnail];
            [youtubeVideoList addObject:video];
        }
        videoList = [[NSArray alloc] initWithArray:youtubeVideoList];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [videoList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VideoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    YoutubeVideo *currentVideo = [videoList objectAtIndex:indexPath.row];
    
    // Configure the cell...
    
    NSString *imageUrl = [NSString stringWithFormat:@"%@",currentVideo.videoThumbnail];
    NSURL *url = [NSURL URLWithString:imageUrl];
    [cell.imageCell setImageWithURL:url usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    
    cell.title.text = currentVideo.videoTitle;
    cell.subtitle.text = currentVideo.videoUpdated;
    
    int duration = [currentVideo.videoDuration intValue];
    int minutes = duration / 60;
    int seconds = duration % 60;
    NSString *time = [NSString stringWithFormat:@"%d:%02d", minutes, seconds];
    cell.behind.text = [NSString stringWithFormat:@"%@",time];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    YoutubeVideo *currentVideo = [videoList objectAtIndex:[self.tableView indexPathForSelectedRow].row];
    if ([[segue identifier] isEqualToString:@"ShowView"]) {
        DetailShowViewController *vc = [segue destinationViewController];
        vc.videoToDetail = currentVideo;
    }
}


@end
