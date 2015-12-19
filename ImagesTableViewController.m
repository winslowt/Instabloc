//
//  ImagesTableViewController.m
//  
//
//  Created by Tony  Winslow on 11/29/15.
//
//

#import "ImagesTableViewController.h"
#import "DataStores.h"
#import "MediaPlay.h"
#import "User.h"
#import "Comments.h"
#import "MediaTableViewCell.h"
#import "MediaFullScreenViewController.h"
#import "ShareUtilities.h"


@interface ImagesTableViewController () <MediaTableViewCellDelegate>

@end

@implementation ImagesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[DataStores sharedInstance] addObserver:self forKeyPath:@"mediaItems" options:0 context:nil];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshControlDidFire:) forControlEvents:UIControlEventValueChanged];
    
    [self.tableView registerClass:[MediaTableViewCell class] forCellReuseIdentifier:@"mediaCell"];
    
    [[DataStores sharedInstance] requestNewItemsWithCompletionHandler:nil];
    
    
}

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    MediaPlay *mediaItem = [DataStores sharedInstance].mediaItems[indexPath.row];
    //of the data store, which is only 1
    if (mediaItem.downloadState == MediaDownloadStateNeedsImage && self.isDecelerating && self.isScrolling) { //TODO: Add an extra check here to make sure we're not accelerating or dragging
        [[DataStores sharedInstance] downloadImageForMediaItem:mediaItem];
    }
}


- (void) cell:(MediaTableViewCell *)cell didLongPressImageView:(UIImageView *)imageView {
  
    [ShareUtilities shareMediaItem:cell.mediaItem fromVC:self];
    
}

- (CGFloat) tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MediaPlay *item = [DataStores sharedInstance].mediaItems[indexPath.row];
    if (item.image) {
        return 350;
    } else {
        return 150;
    }
}


- (void) infiniteScrollIfNecessary {
    // #3
    NSIndexPath *bottomIndexPath = [[self.tableView indexPathsForVisibleRows] lastObject];
    
    if (bottomIndexPath && bottomIndexPath.row == [DataStores sharedInstance].mediaItems.count - 1) {
        // The very last cell is on screen
        [[DataStores sharedInstance] requestOldItemsWithCompletionHandler:nil];
    }
}

#pragma mark - UIScrollViewDelegate

// #4
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self infiniteScrollIfNecessary];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    self.isScrolling = YES;
    NSLog(@"scrollViewWillBeginDragging");
    
}
    
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerating {
        //[super scrollViewDidEndDragging:scrollView willDecelerate:decelerate];    // pull to refresh
        
        if(!decelerating) {
            self.isScrolling = NO;
        }
        NSLog(@"%@scrollViewDidEndDragging", self.isScrolling ? @"" : @"-");
        
        
        self.decelerationRate = UIScrollViewDecelerationRateNormal;
    

    
    //TODO: Use UIScrollViewDelegate methods to save variables that help you check decelerating state and dragging
    
    //TODO: If you set isDecelerating = YES, make sure to also set when you're not decelerating (isDecelerating = NO)
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    
    self.isScrolling = YES;
    NSLog(@"Scroll view is decelerating");
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    self.isScrolling = NO;
    
    NSLog(@"Scroll view is NOT decelerating");
    
}


- (void) refreshControlDidFire:(UIRefreshControl *) sender {
    [[DataStores sharedInstance] requestNewItemsWithCompletionHandler:^(NSError *error) {
        [sender endRefreshing];
    }];
}

- (void) dealloc
{
    [[DataStores sharedInstance] removeObserver:self forKeyPath:@"mediaItems"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == [DataStores sharedInstance] && [keyPath isEqualToString:@"mediaItems"]) {
    
        
        // We know mediaItems changed.  Let's see what kind of change it is.
        NSKeyValueChange kindOfChange = [change[NSKeyValueChangeKindKey] unsignedIntegerValue];
        
        if (kindOfChange == NSKeyValueChangeSetting) {
            // Someone set a brand new images array
            [self.tableView reloadData];
        } else if (kindOfChange == NSKeyValueChangeInsertion ||
                   kindOfChange == NSKeyValueChangeRemoval ||
                   kindOfChange == NSKeyValueChangeReplacement) {
            // We have an incremental change: inserted, deleted, or replaced images
            
            // Get a list of the index (or indices) that changed
            NSIndexSet *indexSetOfChanges = change[NSKeyValueChangeIndexesKey];
            
            // #1 - Convert this NSIndexSet to an NSArray of NSIndexPaths (which is what the table view animation methods require)
            NSMutableArray *indexPathsThatChanged = [NSMutableArray array];
            [indexSetOfChanges enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
                NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:idx inSection:0];
                [indexPathsThatChanged addObject:newIndexPath];
            }];
            
            [self.tableView beginUpdates];
            
            // Tell the table view what the changes are
            if (kindOfChange == NSKeyValueChangeInsertion) {
                [self.tableView insertRowsAtIndexPaths:indexPathsThatChanged withRowAnimation:UITableViewRowAnimationAutomatic];
            } else if (kindOfChange == NSKeyValueChangeRemoval) {
                
                
                [self.tableView deleteRowsAtIndexPaths:indexPathsThatChanged withRowAnimation:UITableViewRowAnimationAutomatic];
                
                
            } else if (kindOfChange == NSKeyValueChangeReplacement) {
                [self.tableView reloadRowsAtIndexPaths:indexPathsThatChanged withRowAnimation:UITableViewRowAnimationAutomatic];
            }
            
            // Tell the table view that we're done telling it about changes, and to complete the animation
            [self.tableView endUpdates];
        }
    }
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return [self items].count;
    
}


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
    }
    return self;
}
#pragma mark - MediaTableViewCellDelegate

- (void) cell:(MediaTableViewCell *)cell didTapImageView:(UIImageView *)imageView {
    
    MediaFullScreenViewController *fullScreenVC = [[MediaFullScreenViewController alloc] initWithMedia:cell.mediaItem];
    
    [self presentViewController:fullScreenVC animated:YES completion:nil];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    MediaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mediaCell" forIndexPath:indexPath];
    cell.delegate = self;
    cell.mediaItem = [DataStores sharedInstance].mediaItems[indexPath.row];
    
    
    return cell;
}


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MediaPlay *item = [DataStores sharedInstance].mediaItems[indexPath.row];
    
    return [MediaTableViewCell heightForMediaItem:item width:CGRectGetWidth(self.view.frame)];
}

-(NSArray *)items {
    
    return [DataStores sharedInstance].mediaItems ;
}




- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    
    MediaPlay *item = [self items][indexPath.row];
    if (item) return YES;
    return NO;
}



- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        MediaPlay *item = [self items][indexPath.row];
        
        [[DataStores sharedInstance] moveMediaItem:item];
        
        
    }
}

//
//- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath
//       toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
//    
//    NSDictionary *section = [self.images objectAtIndex:sourceIndexPath.section];
//    
//    NSUInteger sectionCount = [[section valueForKey:@"content"] count];
//    
//    if (sourceIndexPath.section != proposedDestinationIndexPath.section) {
//        NSUInteger rowInSourceSection =
//        (sourceIndexPath.section > proposedDestinationIndexPath.section) ?
//        0 : sectionCount - 1;
//        
//        return [NSIndexPath indexPathForRow:rowInSourceSection inSection:sourceIndexPath.section];
//    } else if (proposedDestinationIndexPath.row >= sectionCount) {
//        return [NSIndexPath indexPathForRow:sectionCount - 1 inSection:sourceIndexPath.section];
//    }
//    // Allow the proposed destination.
//    return proposedDestinationIndexPath;

//    
//    proposedDestinationIndexPath = 0;
//    
//    if (sourceIndexPath == proposedDestinationIndexPath) {
//        
//        
//    }

//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
//    // Return NO if you do not want the item to be re-orderable.
//    return YES;
//}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
