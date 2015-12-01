//
//  Comments.h
//  
//
//  Created by Tony  Winslow on 11/29/15.
//
//

#import <Foundation/Foundation.h>
@class User;

@interface Comments : NSObject


@property (nonatomic, strong) NSString *idNumber;

@property (nonatomic, strong) User *from;
@property (nonatomic, strong) NSString *text;


@end
