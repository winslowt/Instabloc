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


- (void) moveMediaItem:(MediaPlay *)item;

- (void) requestNewItemsWithCompletionHandler:(NewItemCompletionBlock)completionHandler;
- (void) requestOldItemsWithCompletionHandler:(NewItemCompletionBlock)completionHandler;


@end