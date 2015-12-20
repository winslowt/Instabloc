//
//  DataStores.h
//  
//
//  Created by Tony  Winslow on 11/29/15.
//
//

#import <Foundation/Foundation.h>


@class MediaPlay;

typedef void (^NewItemCompletionBlock)(NSError *error);

@interface DataStores : NSObject

+(instancetype) sharedInstance;


@property (nonatomic, strong, readonly) NSArray *mediaItems;
@property (nonatomic, strong, readonly) NSString *accessToken;


- (void) moveMediaItem:(MediaPlay *)item;

- (void) requestNewItemsWithCompletionHandler:(NewItemCompletionBlock)completionHandler;
- (void) requestOldItemsWithCompletionHandler:(NewItemCompletionBlock)completionHandler;
- (void) downloadImageForMediaItem:(MediaPlay *)mediaItem;
- (void) toggleLikeOnMediaItem:(MediaPlay *)mediaItem withCompletionHandler:(void (^)(void))completionHandler;
- (void) commentOnMediaItem:(MediaPlay *)mediaItem withCommentText:(NSString *)commentText;


+ (NSString *) instagramClientID; 

@end