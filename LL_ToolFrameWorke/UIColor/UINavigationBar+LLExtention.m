//
//  UINavigationBar+LLExtention.m
//  VCTalk
//
//  Created by Liliang on 2018/1/11.
//  Copyright © 2018年 Qingke.liliang. All rights reserved.
//

#import "UINavigationBar+LLExtention.h"
#import <objc/runtime.h>
static const void *kleftValue = "leftValue";
@implementation UINavigationBar (LLExtention)
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];


}
- (CGFloat )leftValue {
    id obj = objc_getAssociatedObject(self, &kleftValue);
    if(obj != nil && [obj isKindOfClass:[NSNumber class]])
    {
        return [obj floatValue];
    }
    else
    {
        return 0.0001;
    }
    
}

- (void)setLeftValue:(CGFloat)leftValue
{
    objc_setAssociatedObject(self, kleftValue, [NSNumber numberWithFloat:leftValue], OBJC_ASSOCIATION_COPY_NONATOMIC);
    if ([UIDevice currentDevice].systemVersion.floatValue >= 11.0) {
        for (UIView *view in self.subviews) {
            for (UIView *subView in view.subviews) {
                if ([NSStringFromClass(subView.class) isEqualToString:@"UIButton"]) {
                    NSLog(@"vida ");
                    subView.frame = CGRectMake(self.leftValue, subView.frame.origin.y, subView.frame.size.width, subView.frame.size.height);
                }
            }
        }
    }else{
        for (int i=0; i<self.subviews.count; i++) {
            UIView *t_view = self.subviews[i];
            if (i==0) {
                t_view.frame = CGRectMake(self.leftValue, t_view.frame.origin.y, t_view.frame.size.width, t_view.frame.size.height);
            }
        }
    }
}

@end
