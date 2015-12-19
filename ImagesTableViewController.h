//
//  ImagesTableViewController.h
//  
//
//  Created by Tony  Winslow on 11/29/15.
//
//

#import <UIKit/UIKit.h>

@interface ImagesTableViewController : UITableViewController
@property (nonatomic, strong) NSMutableArray *images;
@property(nonatomic) CGFloat decelerationRate;
@property(nonatomic, readonly, getter=isDecelerating) BOOL decelerating;
@property (nonatomic) BOOL isScrolling;





@end
