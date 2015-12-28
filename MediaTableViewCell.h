//
//  MediaTableViewCell.h
//  
//
//  Created by Tony  Winslow on 11/29/15.
//
//

#import <UIKit/UIKit.h>

@class MediaPlay, MediaTableViewCell, ComposeCommentView;

@protocol MediaTableViewCellDelegate <NSObject>

- (void) cell:(MediaTableViewCell *)cell didTapImageView:(UIImageView *)imageView;
- (void) cell:(MediaTableViewCell *)cell didLongPressImageView:(UIImageView *)imageView;
- (void) cellDidPressLikeButton:(MediaTableViewCell *)cell;
- (void) cellWillStartComposingComment:(MediaTableViewCell *)cell;
- (void) cell:(MediaTableViewCell *)cell didComposeComment:(NSString *)comment;


@end

@interface MediaTableViewCell : UITableViewCell

@property (nonatomic, strong) MediaPlay *mediaItem;
@property (nonatomic, weak) id <MediaTableViewCellDelegate> delegate;
@property (nonatomic, strong, readonly) ComposeCommentView *commentView;
@property (nonatomic, strong) UITraitCollection *overrideTraitCollection;
@property (nonatomic, strong) NSLayoutConstraint *imageHeightConstraint;
//@property (nonatomic, strong) NSLayoutConstraint *usernameAndCaptionLabelHeightConstraint;
//@property (nonatomic, strong) NSLayoutConstraint *commentLabelHeightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *imageWidthConstraint;



+ (CGFloat) heightForMediaItem:(MediaPlay *)mediaItem width:(CGFloat)width traitCollection:(UITraitCollection *) traitCollection;


- (void) stopComposingComment;



@end
