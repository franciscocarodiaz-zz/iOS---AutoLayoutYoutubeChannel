#import "DetailShowViewController.h"
#import "ContainerViewController.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "ModalAnimator.h"
#import "CustomAlertViewController.h"

@interface DetailShowViewController ()<UIViewControllerTransitioningDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation DetailShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpEverything];
}

- (void)setUpEverything {
    self.title = self.videoToDetail.videoTitle;
    //self.imageView.image = self.videoToDetail.image;
    NSString *imageUrl = [NSString stringWithFormat:@"%@",self.videoToDetail.videoThumbnail];
    NSURL *url = [NSURL URLWithString:imageUrl];
    [self.imageView setImageWithURL:url usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
}
- (IBAction)viewVideoButtonPressed:(id)sender {
    self.webView.hidden = NO;
    self.imageView.hidden = YES;
    NSString *youTubeVideoHTML = @"<!DOCTYPE html><html><head><style>body{margin:0px 0px 0px 0px;}</style></head> <body> <div id=\"player\"></div> <script> var tag = document.createElement('script'); tag.src = \"http://www.youtube.com/player_api\"; var firstScriptTag = document.getElementsByTagName('script')[0]; firstScriptTag.parentNode.insertBefore(tag, firstScriptTag); var player; function onYouTubePlayerAPIReady() { player = new YT.Player('player', { width:'%0.0f', height:'%0.0f', videoId:'%@', events: { 'onReady': onPlayerReady, } }); } function onPlayerReady(event) { event.target.playVideo(); } </script> </body> </html>";
    
    NSString *html = [NSString stringWithFormat:youTubeVideoHTML, self.imageView.frame.size.width, self.imageView.frame.size.height, self.videoToDetail.videoId];
    
    [self.webView loadHTMLString:html  baseURL:[[NSBundle mainBundle] resourceURL]];
}
- (IBAction)shareButtonPressed:(id)sender {
    
    NSString *msg = [NSString stringWithFormat:@"Disfrutando del canal de Youtube desde la aplicación para iPhone. \n"];
    
    NSString *linkVideo = [NSString stringWithFormat:@"https://m.youtube.com/details?v=%@",self.videoToDetail.videoId];
    
    NSArray *itemsToShare =  @[msg,self.imageView.image,linkVideo];
    
    UIActivityViewController *activiyVC = [[UIActivityViewController alloc] initWithActivityItems:itemsToShare applicationActivities:nil];
    activiyVC.excludedActivityTypes = @[];
    [self presentViewController:activiyVC animated:YES completion:nil];
}

- (IBAction)seenButtonPressed:(id)sender {
    
    
    /*
    self.videoToDetail.watched = !self.videoToDetail.watched;
    if (self.videoToDetail.watched) {
        //Button selected
    }
    else {
        //Button unselected
    }
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Transition

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    
    ModalAnimator *animator = [[ModalAnimator alloc]init];
    animator.presenting = YES;
    
    return animator;
    
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    ModalAnimator *animator = [[ModalAnimator alloc]init];
    animator.presenting = NO;
    
    return animator;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"Container"]) {
        ContainerViewController *vc = [segue destinationViewController];
        vc.updatedText = self.videoToDetail.videoUpdated;
        vc.overviewText = self.videoToDetail.videoDescription;
    }else if ([[segue identifier] isEqualToString:@"showVideo"]) {
//        CustomAlertViewController *detailVC = [segue destinationViewController];
//        detailVC.videoId = self.videoToDetail.videoId;
//        detailVC.transitioningDelegate = self;
//        detailVC.modalPresentationStyle = UIModalPresentationCustom;
    }
}


@end
