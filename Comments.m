//
//  Comments.m
//  
//
//  Created by Tony  Winslow on 11/29/15.
//
//

#import "Comments.h"
#import "User.h"

@implementation Comments

- (instancetype) initWithDictionary:(NSDictionary *)commentDictionary {
    self = [super init];
    
    if (self) {
        self.idNumber = commentDictionary[@"id"];
        self.text = commentDictionary[@"text"];
        self.from = [[User alloc] initWithDictionary:commentDictionary[@"from"]];
    }
    
    return self;
}

@end
