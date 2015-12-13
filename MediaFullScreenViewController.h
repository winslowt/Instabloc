//
//  MediaFullScreenViewController.h
//  
//
//  Created by Tony  Winslow on 12/13/15.
//
//

#import <UIKit/UIKit.h>

@class MediaPlay;

@interface MediaFullScreenViewController : UIViewController

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;

- (instancetype) initWithMedia:(MediaPlay *)media;

- (void) centerScrollView;

@end