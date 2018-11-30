//
//  NSString+LLExtention.h
//  FamilyDoctor
//
//  Created by markLi on 2018/11/1.
//  Copyright © 2018 pan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (LLExtention)
- (BOOL)notEmpty;
-(CGFloat)calculationStringSize:(CGFloat)width andWithTextFont:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
