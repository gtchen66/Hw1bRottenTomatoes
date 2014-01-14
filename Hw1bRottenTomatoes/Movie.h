//
//  Movie.h
//  Hw1bRottenTomatoes
//
//  Created by George Chen on 1/11/14.
//  Copyright (c) 2014 George Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray *cast;
@property (nonatomic, strong) NSString *summary;
@property (nonatomic, strong) NSString *posterUrl;
@property (nonatomic, strong) NSString *bigPosterUrl;

- (id) initWithDictionary:(NSDictionary *)dictionary;

@end
