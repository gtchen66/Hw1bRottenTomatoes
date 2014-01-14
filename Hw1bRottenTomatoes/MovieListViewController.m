//
//  MovieListViewController.m
//  Hw1bRottenTomatoes
//
//  Created by George Chen on 1/8/14.
//  Copyright (c) 2014 George Chen. All rights reserved.
//

#import "MovieListViewController.h"
#import "MovieCell.h"
#import "Movie.h"
#import "MovieDetailTableViewController.h"

@interface MovieListViewController ()

@property (nonatomic, strong) NSArray *movies;
@property (nonatomic, strong) NSMutableArray *myMovies;

@end

@implementation MovieListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        NSLog(@"inside initWithStyle");
        // Custom initialization
        // self.movies = [NSArray array];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        NSLog(@"inside initWithCoder");
        self.myMovies = [NSMutableArray array];
        
        // pull data from rottentomatoes webapi
        // use dvds/top_rentals for rentals
        NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json?apikey=g9au4hv6khv6wzvzgt55gpqs";
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue]
            completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];

            self.movies = [object valueForKeyPath:@"movies"];

            // loop through movies
            int movieIndex;
            for (movieIndex=0; movieIndex<self.movies.count; movieIndex++) {
                NSDictionary *movie = [self.movies objectAtIndex:movieIndex];
                Movie *m = [[Movie alloc] initWithDictionary:movie];
                [self.myMovies addObject:m];
            }
                
            [self.tableView reloadData];
            NSLog(@"%@", object);
            NSLog(@"Added %d movies",self.myMovies.count);

        }];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

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
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MovieCell";
    
    // Use MovieCell instead of UITableViewCell
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    NSDictionary *movie = [self.movies objectAtIndex:indexPath.row];
    
    cell.movieTitleLabel.text      = [movie objectForKey:@"title"];
    cell.summarySypnosisLabel.text = [movie objectForKey:@"synopsis"];
    
    // URL with movie poster
    // The following works but is BAD idea
    // Replace this with an asynchronous call ASAP
    //
    NSString *movieThumbnailString = [[movie objectForKey:@"posters"] objectForKey:@"thumbnail"];
    NSURL *url = [NSURL URLWithString:movieThumbnailString];
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:url];
    cell.posterImageView.image = [UIImage imageWithData:imageData];

    return cell;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"segueToMovieDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        MovieDetailTableViewController *mvc = [segue destinationViewController];
        mvc.movieIndexToView = indexPath;
        mvc.movieToDisplay = [self.myMovies objectAtIndex:indexPath.row];
        
    }
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
