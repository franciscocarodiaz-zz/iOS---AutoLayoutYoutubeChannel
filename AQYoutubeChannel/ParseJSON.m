//
//  ParseJSON.m
//  WeatherWorld
//
//  Created by Francisco Caro Diaz on 05/11/14.
//  Copyright (c) 2014 ironhack. All rights reserved.
//

#import "ParseJSON.h"
#import <Mantle/Mantle.h>

@interface ParseJSON()

@end

@implementation ParseJSON

+(NSDictionary *) listOfVideos:(NSString *)urlYoutubeChannel{
    
    NSDictionary *JSONDictionary;
    NSString *urlString = [NSString stringWithFormat:@"%@",urlYoutubeChannel];
    JSONDictionary = [self getJSONFromRemote:urlString];
    
    return JSONDictionary;
}

+ (NSDictionary *)getJSONFromRemote:(NSString *)url{
    
    NSString *urlUTF8 = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *jsonURL = [NSURL URLWithString:urlUTF8];
    NSData *seriesData = [NSData dataWithContentsOfURL:jsonURL];
    NSError *error;
    NSDictionary *JSONDictionary = [NSJSONSerialization JSONObjectWithData:seriesData options:NSJSONReadingMutableContainers error:&error];
    NSLog(@"Error: %@",error);
    return JSONDictionary;
}

@end
