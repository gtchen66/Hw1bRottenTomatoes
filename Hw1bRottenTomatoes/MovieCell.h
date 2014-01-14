//
//  MovieCell.h
//  Hw1bRottenTomatoes
//
//  Created by George Chen on 1/11/14.
//  Copyright (c) 2014 George Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *posterImageView;
@property (nonatomic, weak) IBOutlet UILabel *movieTitleLabel;
@property (nonatomic, weak) IBOutlet UILabel *summarySypnosisLabel;

@end
