//
//  YoutubeVideo.h
//  seff2014
//
//  Created by Francisco Caro Diaz on 05/11/14.
//  Copyright (c) 2014 arequa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YoutubeVideo : NSObject

@property (nonatomic, strong) NSString *videoId;
@property (nonatomic, strong) NSString *videoDescription;
@property (nonatomic, strong) NSString *videoUpdated;
@property (nonatomic, strong) NSString *videoDuration;
@property (nonatomic, strong) NSString *videoTitle;
@property (nonatomic, strong) NSString *videoThumbnail;

-(instancetype)initWithId:(NSString *)idVideo withDescription:(NSString *)description withUpdated:(NSString *)updated withDuration:(NSString *)duration withTitle:(NSString *)title withThumbnail:(NSString *)thumbnail;
-(YoutubeVideo *)getVideo:(NSDictionary *)jsonData;
@end
