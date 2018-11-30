//
//  NSString+LLExtention.m
//  FamilyDoctor
//
//  Created by markLi on 2018/11/1.
//  Copyright © 2018 pan. All rights reserved.
//
#import <UIKit/UIKit.h>

#import "NSString+LLExtention.h"

@implementation NSString (LLExtention)
- (BOOL)notEmpty
{
    return (self !=nil && [self length]) > 0 ? YES : NO;

}

-(CGFloat)calculationStringSize:(CGFloat)width andWithTextFont:(UIFont *)font
{
    return  [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size.height;

}

@end
