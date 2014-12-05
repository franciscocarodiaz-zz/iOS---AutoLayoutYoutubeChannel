//
//  CustomAlertViewController.m
//  Inclass_ironhackBCN
//
//  Created by Francisco Caro Diaz on 24/10/14.
//  Copyright (c) 2014 ironhack. All rights reserved.
//

#import "CustomAlertViewController.h"

@interface CustomAlertViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation CustomAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    NSString* embedHTML = [NSString stringWithFormat:@"\
                           <html>\
                           <body style='margin:0px;padding:0px;'>\
                           <script type='text/javascript' src='http://www.youtube.com/iframe_api'></script>\
                           <script type='text/javascript'>\
                           function onYouTubeIframeAPIReady()\
                           {\
                           ytplayer=new YT.Player('playerId',{events:{onReady:onPlayerReady}})\
                           }\
                           function onPlayerReady(a)\
                           { \
                           a.target.playVideo(); \
                           }\
                           </script>\
                           <iframe id='playerId' type='text/html' width='%d' height='%d' src='http://www.youtube.com/embed/%@?enablejsapi=1&rel=0&playsinline=1&autoplay=1' frameborder='0'>\
                           </body>\
                           </html>", 300, 200, self.videoId];
    //[self.webView loadHTMLString:embedHTML baseURL:[[NSBundle mainBundle] resourceURL]];
    
    
    NSString* videoId = self.videoId;
    
    NSString *htmlString = @"<html><head>\
    <meta name = \"viewport\" content = \"initial-scale = 1.0, user-scalable = no, width = 320\"/></head>\
    <body style=\"background:#000;margin-top:0px;margin-left:0px\">\
    <script type='text/javascript' src='http://www.youtube.com/iframe_api'></script>\
    <script type='text/javascript'>\
    function onYouTubeIframeAPIReady()\
    {\
    ytplayer=new YT.Player('playerId',{events:{onReady:onPlayerReady}})\
    }\
    function onPlayerReady(a)\
    { \
    a.target.playVideo(); \
    }\
    </script>\
    <iframe id=\"ytplayer\" type=\"text/html\" width=\"250\" height=\"172\"\
    src=\"http://www.youtube.com/embed/%@?enablejsapi=1&rel=0&playsinline=1&autoplay=1\"\
    frameborder=\"0\"/>\
    </body></html>";
    
    htmlString = [NSString stringWithFormat:htmlString, videoId, videoId];
    
    //[self.webView loadHTMLString:htmlString baseURL:[[NSBundle mainBundle] resourceURL]];
    
    NSString *youTubeVideoHTML = @"<!DOCTYPE html><html><head><style>body{margin:0px 0px 0px 0px;}</style></head> <body> <div id=\"player\"></div> <script> var tag = document.createElement('script'); tag.src = \"http://www.youtube.com/player_api\"; var firstScriptTag = document.getElementsByTagName('script')[0]; firstScriptTag.parentNode.insertBefore(tag, firstScriptTag); var player; function onYouTubePlayerAPIReady() { player = new YT.Player('player', { width:'%0.0f', height:'%0.0f', videoId:'%@', events: { 'onReady': onPlayerReady, } }); } function onPlayerReady(event) { event.target.playVideo(); } </script> </body> </html>";
    
    NSString *html = [NSString stringWithFormat:youTubeVideoHTML, self.webView.frame.size.width, self.webView.frame.size.height, videoId];
    
    [self.webView loadHTMLString:html baseURL:[[NSBundle mainBundle] resourceURL]];
}

- (IBAction)touchAcceptButton:(UIButton *)sender {
    
    
    [self dismissViewControllerAnimated:YES completion:^{
        //
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
