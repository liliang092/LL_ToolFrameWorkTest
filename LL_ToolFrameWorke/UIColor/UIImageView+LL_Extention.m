//
//  UIImageView+LL_Extention.m
//  FamilyDoctor
//
//  Created by markLi on 2018/11/13.
//  Copyright © 2018 pan. All rights reserved.
//

#import "UIImageView+LL_Extention.h"
#import "UIImage+LL_Extention.h"
@implementation UIImageView (LL_Extention)
-(void)addShareDowColor
{
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.bounds;
    gradient.colors = [NSArray arrayWithObjects: (id)[UIColor clearColor].CGColor, (id)[UIColor blackColor].CGColor, nil];
    gradient.startPoint = CGPointMake(0, 0);
    gradient.endPoint = CGPointMake(0, 1);
    gradient.locations = @[ @0.75];
    [self.layer addSublayer:gradient];
    
}
-(void)setNeedsDisplay
{
    [super setNeedsDisplay];
}
-(void)setImageWithClipContent:(ImageClipContent)content andWithImage:(UIImage *)image
{
    
    UIImage *tempImage = [UIImage thumbnailWithImage:image size:self.frame.size andWithClipContent:content];
    self.image = tempImage;
    //    self.contentMode = UIViewContentModeScaleAspectFill;
}
@end
