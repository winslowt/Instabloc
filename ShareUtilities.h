//
//  ShareUtilities.h
//  
//
//  Created by Tony  Winslow on 12/15/15.
//
//

#import <UIKit/UIKit.h>
@class MediaPlay;

@interface ShareUtilities : NSObject

+ (void)shareMediaItem:(MediaPlay *)mediaItem fromVC:(UIViewController *)vc;

@end
