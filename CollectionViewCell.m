//
//  CollectionViewCell.m
//  Instabloc
//
//  Created by Tony  Winslow on 12/28/15.
//  Copyright © 2015 Bloc. All rights reserved.
//

#import "CollectionViewCell.h"



@implementation CollectionViewCell


-(id) initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    CGFloat thumbnailEdgeSize = 150;
    

        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, thumbnailEdgeSize, thumbnailEdgeSize)];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.clipsToBounds = YES;
        
        [self.contentView addSubview:self.imageView];

        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, thumbnailEdgeSize, thumbnailEdgeSize, 20)];
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        self.nameLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:10];
        [self.contentView addSubview:self.nameLabel];
    
    return self;
    
}


@end
