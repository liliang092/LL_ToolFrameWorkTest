//
//  UIButton+LL_Extenttion.m
//  FamilyDoctor
//
//  Created by markLi on 2018/10/31.
//  Copyright © 2018 pan. All rights reserved.
//

#import "UIButton+LL_Extenttion.h"

@implementation UIButton (LL_Extenttion)
-(void)buttonStytle:(ButtonTitleAndImageStyle)stytle andWithEdge:(CGFloat)edge;
{
    switch (stytle) {
        case TitleLeftImageRight:
        {
            
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.imageView.frame.size.width-edge, 1, self.imageView.frame.size.width)];
            [self setImageEdgeInsets:UIEdgeInsetsMake(0, self.titleLabel.frame.size.width, 0,- self.titleLabel.frame.size.width)];
        }
            break;
        case TitleRightImageLeft:
        {
            
        }
            break;
        case TitleUpImageDown:
        {
            [self setTitleEdgeInsets:UIEdgeInsetsMake(-self.imageView.frame.size.height, -self.imageView.frame.size.width, self.imageView.frame.size.height, 0)];
            [self setImageEdgeInsets:UIEdgeInsetsMake(self.titleLabel.frame.size.height, self.titleLabel.bounds.size.width, -self.titleLabel.frame.size.height, 0)];
        }
            break;
        case TitleDownImagUp:
        {
            float  spacing = edge;//图片和文字的上下间距
            CGSize imageSize = self.imageView.frame.size;
            CGSize titleSize = self.titleLabel.frame.size;
            CGSize textSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName : self.titleLabel.font}];
            CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
            if (titleSize.width + 0.5 < frameSize.width) {
                titleSize.width = frameSize.width;
            }
            CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
            self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0);
        }
            break;
            
        default:
            break;
    }
}
@end
