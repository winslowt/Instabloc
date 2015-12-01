//
//  MediaTableViewCell.h
//  
//
//  Created by Tony  Winslow on 11/29/15.
//
//

#import <UIKit/UIKit.h>

@class MediaPlay;

@interface MediaTableViewCell : UITableViewCell

@property (nonatomic, strong) MediaPlay *mediaItem;
@property (nonatomic, strong) NSLayoutConstraint *imageHeightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *usernameAndCaptionLabelHeightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *commentLabelHeightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *imageWidthConstraint;


+ (CGFloat) heightForMediaItem:(MediaPlay *)mediaItem width:(CGFloat)width;



@end
