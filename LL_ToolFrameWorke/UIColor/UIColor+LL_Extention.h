//
//  UIColor+LL_Extention.h
//  FamilyDoctor
//
//  Created by markLi on 2018/10/31.
//  Copyright © 2018 pan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (LL_Extention)
+ (UIColor *) randomColor;

+(UIColor *)getColors:(NSString *) stringToConvert;



+ (UIColor *) colorWithHexString:(NSString *)color andAlpha:(float)alpha;


@end

NS_ASSUME_NONNULL_END
