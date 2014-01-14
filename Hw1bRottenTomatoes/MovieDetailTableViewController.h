//
//  MovieDetailTableViewController.h
//  Hw1bRottenTomatoes
//
//  Created by George Chen on 1/13/14.
//  Copyright (c) 2014 George Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface MovieDetailTableViewController : UITableViewController

@property (nonatomic, strong) NSIndexPath *movieIndexToView;
@property (nonatomic, strong) Movie *movieToDisplay;

@end
