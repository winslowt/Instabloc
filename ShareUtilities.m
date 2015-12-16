//
//  ShareUtilities.m
//  
//
//  Created by Tony  Winslow on 12/15/15.
//
//

#import "ShareUtilities.h"
#import "MediaPlay.h"

@implementation ShareUtilities

+(void)shareMediaItem:(MediaPlay *)mediaItem fromVC:(UIViewController *)vc {
    NSMutableArray *itemsToShare = [NSMutableArray array];
    
    if (mediaItem.caption.length > 0) {
        [itemsToShare addObject:mediaItem.caption];
    }
    
    if (mediaItem.image) {
        [itemsToShare addObject:mediaItem.image];
    }
    
    if (itemsToShare.count > 0) {
        UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:itemsToShare applicationActivities:nil];
        [vc presentViewController:activityVC animated:YES completion:nil];
    }
   
}

@end

