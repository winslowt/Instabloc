//
//  Consumer.h
//  
//
//  Created by Tony  Winslow on 11/29/15.
//
//

#import <UIKit/UIKit.h>

@interface User: NSObject

@property (nonatomic, strong) NSString *idNumber;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *fullName;
@property (nonatomic, strong) NSURL *profilePictureURL;
@property (nonatomic, strong) UIImage *profilePicture;

@end
