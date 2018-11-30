//
//  UIButton+LL_Extenttion.h
//  FamilyDoctor
//
//  Created by markLi on 2018/10/31.
//  Copyright © 2018 pan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    TitleLeftImageRight,
    TitleUpImageDown,
    TitleDownImagUp,
    TitleRightImageLeft
} ButtonTitleAndImageStyle;
@interface UIButton (LL_Extenttion)
-(void)buttonStytle:(ButtonTitleAndImageStyle)stytle andWithEdge:(CGFloat)edge;

@end

NS_ASSUME_NONNULL_END
