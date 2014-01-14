//
//  MovieDetailTableViewController.m
//  Hw1bRottenTomatoes
//
//  Created by George Chen on 1/13/14.
//  Copyright (c) 2014 George Chen. All rights reserved.
//

#import "MovieDetailTableViewController.h"

@interface MovieDetailTableViewController ()
@property (weak, nonatomic) IBOutlet UILabel *MovieDetailTitleLabel;

@end

@implementation MovieDetailTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSLog(@"inside viewDidLoad in MovieDetailTableViewController");
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
   
    NSString *cellTypeTitle   = @"MovieDetailTitleCell";
    NSString *cellTypeSummary = @"MovieDetailSummaryCell";
    NSString *cellTypeCast    = @"MovieDetailCastCell";
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:cellTypeTitle forIndexPath:indexPath];
        cell.textLabel.text = self.movieToDisplay.title;
    }
    else if (indexPath.row == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:cellTypeSummary forIndexPath:indexPath];
        cell.textLabel.text = self.movieToDisplay.summary;
        NSLog(@"length of summary %d",[self.movieToDisplay.summary length]);
    }
    else if (indexPath.row == 2) {
        cell = [tableView dequeueReusableCellWithIdentifier:cellTypeCast forIndexPath:indexPath];
        NSArray *ary = [[NSArray alloc] initWithArray:self.movieToDisplay.cast];
        // NSLog(@"in row 3 and ary has %d elements",[ary count]);
        
        NSString *castList = [[NSString alloc] init];
        int i;
        for (i=0; i<[ary count]; i++) {
            NSDictionary *actor = [ary objectAtIndex:i];
            castList = [[castList stringByAppendingString:[actor objectForKey:@"name"]] stringByAppendingFormat:@"\n"];
        }
        NSLog(@"cast is <<%@>>", castList);
        cell.textLabel.text = castList;
    }
    else if (indexPath.row == 3) {
        // reuse the Cast cell
        cell = [tableView dequeueReusableCellWithIdentifier:cellTypeCast forIndexPath:indexPath];
        
        NSURL *url = [NSURL URLWithString:self.movieToDisplay.bigPosterUrl];
        NSData *imageData = [[NSData alloc] initWithContentsOfURL:url];
        cell.imageView.image = [UIImage imageWithData:imageData];
        cell.textLabel.text = @"";
        
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat rowHeight = 50;
    if (indexPath.row == 1) {

        // This should be a function of how much needs to be displayed.
        // Instead, taking an estimate based on string length and font size.

        // rowHeight = 200;
        UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
        int summaryLength = [self.movieToDisplay.summary length];
        
        if (UIDeviceOrientationIsLandscape(orientation)) {
            rowHeight = round(([self.movieToDisplay.summary length] / 85) + 0.5 )* 200 / 13;
            NSLog(@"landscape, %d -> %f lines", summaryLength, rowHeight);
            
        } else {
            rowHeight = round((summaryLength / 45) + 0.5 )* 200 / 13;
            NSLog(@"portrait, %d -> %f lines", summaryLength, rowHeight);
        }
    }
    else if (indexPath.row == 2) {
        int numOfCast = [self.movieToDisplay.cast count];
        rowHeight = numOfCast * 20;
    }
    else if (indexPath.row == 3) {
        rowHeight = 300;
    }
    return rowHeight;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
