//
//  UIImage+ImageUtilities.h
//  
//
//  Created by Tony  Winslow on 12/21/15.
//
//

#import <UIKit/UIKit.h>


@interface UIImage (ImageUtilities)

- (UIImage *) imageWithFixedOrientation;
- (UIImage *) imageResizedToMatchAspectRatioOfSize:(CGSize)size;
- (UIImage *) imageCroppedToRect:(CGRect)cropRect;
- (UIImage *) imageByScalingToSize:(CGSize)size andCroppingWithRect:(CGRect)rect;

@end
