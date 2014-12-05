//
//  YoutubeVideo.m
//  seff2014
//
//  Created by Francisco Caro Diaz on 05/11/14.
//  Copyright (c) 2014 arequa. All rights reserved.
//

#import "YoutubeVideo.h"

@implementation YoutubeVideo

-(instancetype)initWithId:(NSString *)idVideo withDescription:(NSString *)description withUpdated:(NSString *)updated withDuration:(NSString *)duration withTitle:(NSString *)title withThumbnail:(NSString *)thumbnail{
    self = [super init];
    if (self) {
        _videoId = idVideo;
        _videoDescription = description;
        _videoUpdated = updated;
        _videoDuration = duration;
        _videoTitle = title;
        _videoThumbnail = thumbnail;
    }
    return self;
}

-(YoutubeVideo *)getVideo:(NSDictionary *)jsonData{
    YoutubeVideo *video;
    
    return video;
}
@end
