//
//  Movie.m
//  Hw1bRottenTomatoes
//
//  Created by George Chen on 1/11/14.
//  Copyright (c) 2014 George Chen. All rights reserved.
//

#import "Movie.h"

@implementation Movie

- (id) initWithDictionary:(NSDictionary *)dictionary {
    self.title = [dictionary objectForKey:@"title"];
    self.cast = [dictionary objectForKey:@"abridged_cast"];
    self.summary = [dictionary objectForKey:@"synopsis"];
    self.posterUrl = [[dictionary objectForKey:@"posters"] objectForKey:@"thumbnail"];
    self.bigPosterUrl = [[dictionary objectForKey:@"posters"] objectForKey:@"detailed"];
    
    return self;
}

@end
