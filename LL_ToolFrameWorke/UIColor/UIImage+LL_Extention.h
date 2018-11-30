//
//  UIImage+LL_Extention.h
//  FamilyDoctor
//
//  Created by markLi on 2018/11/13.
//  Copyright © 2018 pan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+LL_Extention.h"
NS_ASSUME_NONNULL_BEGIN

@interface UIImage (LL_Extention)
+(UIImage *)buttonImageFromColor:(UIColor *)color andWithSize:(CGSize)size;

//给图片添加模糊 模糊度
+(UIImage *)blurryImage:(UIImage *)image withBlurLever:(CGFloat)blur;

+ (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize andWithClipContent:(ImageClipContent)content;

//裁剪出的图片尺寸按照size的尺寸，但图片不拉伸，但多余部分会被裁减掉

+ (UIImage *)thumbnailWithImage:(UIImage *)originalImage size:(CGSize)size andWithClipContent:(ImageClipContent)content;
@end

NS_ASSUME_NONNULL_END
