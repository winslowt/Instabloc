//
//  MediaPlay.h
//  
//
//  Created by Tony  Winslow on 11/29/15.
//
//

#import <UIKit/UIKit.h>

@class User;

@interface MediaPlay : NSObject

@property (nonatomic, strong) NSString *idNumber;
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSURL *mediaURL;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *caption;
@property (nonatomic, strong) NSArray *comments;

@end
