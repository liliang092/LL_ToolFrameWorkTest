//
//  UIImage+LL_Extention.m
//  FamilyDoctor
//
//  Created by markLi on 2018/11/13.
//  Copyright © 2018 pan. All rights reserved.
//

#import "UIImage+LL_Extention.h"
#import <Accelerate/Accelerate.h>

@implementation UIImage (LL_Extention)
+(UIImage *)buttonImageFromColor:(UIColor *)color andWithSize:(CGSize)size{
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

//给图片添加模糊 模糊度
+(UIImage *)blurryImage:(UIImage *)image withBlurLever:(CGFloat)blur
{
    if (image==nil)
    {
        NSLog(@"error:为图片添加模糊效果时，未能获取原始图片");
        return nil;
    }
    //模糊度,
    if (blur < 0.025f) {
        blur = 0.025f;
    } else if (blur > 1.0f) {
        blur = 1.0f;
    }
    
    //boxSize必须大于0
    int boxSize = (int)(blur * 100);
    boxSize -= (boxSize % 2) + 1;
    NSLog(@"boxSize:%i",boxSize);
    //图像处理
    CGImageRef img = image.CGImage;
    //需要引入
    
    //图像缓存,输入缓存，输出缓存
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    //像素缓存
    void *pixelBuffer;
    
    //数据源提供者，Defines an opaque type that supplies Quartz with data.
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    // provider’s data.
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    //宽，高，字节/行，data
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    //像数缓存，字节行*图片高
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    // 第三个中间的缓存区,抗锯齿的效果
    void *pixelBuffer2 = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    vImage_Buffer outBuffer2;
    outBuffer2.data = pixelBuffer2;
    outBuffer2.width = CGImageGetWidth(img);
    outBuffer2.height = CGImageGetHeight(img);
    outBuffer2.rowBytes = CGImageGetBytesPerRow(img);
    //Convolves a region of interest within an ARGB8888 source image by an implicit M x N kernel that has the effect of a box filter.
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer2, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    error = vImageBoxConvolve_ARGB8888(&outBuffer2, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    //    NSLog(@"字节组成部分：%zu",CGImageGetBitsPerComponent(img));
    //颜色空间DeviceRGB
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //用图片创建上下文,CGImageGetBitsPerComponent(img),7,8
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             CGImageGetBitmapInfo(image.CGImage));
    
    //根据上下文，处理过的图片，重新组件
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    free(pixelBuffer);
    free(pixelBuffer2);
    CFRelease(inBitmapData);
    CGImageRelease(imageRef);
    return returnImage;
}
//修改图片尺寸 同比缩放
+ (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize andWithClipContent:(ImageClipContent)content

{
    UIImage *newimage;
    if (nil == image) {
        newimage = nil;
    }
    else{
        CGSize oldsize = image.size;
        CGRect rect;
        if (asize.width/asize.height > oldsize.width/oldsize.height) {
            rect.size.width = asize.height*oldsize.width/oldsize.height;
            rect.size.height = asize.height;
            switch (content) {
                case ClipContentTop:
                {
                    rect.origin.x = 0;
                    rect.origin.y = 0;
                }
                    break;
                case ClipContentBottom:
                {
                    rect.origin.x = 0;
                    rect.origin.y = asize.height - rect.size.height;
                }
                    break;
                    
                default:
                    break;
            }
        }
        else{
            rect.size.width = asize.width;
            rect.size.height = asize.width*oldsize.height/oldsize.width;
            
            switch (content) {
                case ClipContentLeft:
                {
                    rect.origin.x = 0;
                    rect.origin.y = 0;
                }
                    break;
                case ClipContentRight:
                {
                    rect.origin.x = oldsize.width-rect.size.width;
                    rect.origin.y = 0;
                }
                    break;
                    
                default:
                    break;
            }
            
        }
        UIGraphicsBeginImageContext(asize);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        UIRectFill(CGRectMake(0, 0, asize.width, asize.height));//clear background
        
        [image drawInRect:rect];
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return newimage;
}
//裁剪出的图片尺寸按照size的尺寸，但图片不拉伸，但多余部分会被裁减掉

+ (UIImage *)thumbnailWithImage:(UIImage *)originalImage size:(CGSize)size andWithClipContent:(ImageClipContent)content

{
    
    CGSize originalsize = [originalImage size];
    
    //原图长宽均小于标准长宽的，不作处理返回原图
    
    if (originalsize.width<size.width && originalsize.height<size.height)
        
    {
        return originalImage;
    }
    //原图长宽均大于标准长宽的，按比例缩小至最大适应值
    else if(originalsize.width>size.width && originalsize.height>size.height)
        
    {
        CGFloat rate = 1.0;
        CGFloat widthRate = originalsize.width/size.width;
        CGFloat heightRate = originalsize.height/size.height;
        rate = widthRate>heightRate?heightRate:widthRate;
        CGImageRef imageRef = nil;
        if (heightRate>widthRate)
            
        {
            switch (content) {
                case ClipContentTop:
                {
                    CGRect rect =CGRectMake(0, 0, originalsize.width, size.height*rate);
                    imageRef = CGImageCreateWithImageInRect([originalImage CGImage], rect);//获取图片整体部分
                }
                    break;
                case ClipContentBottom:
                {
                    CGRect rect =CGRectMake(0, originalsize.height-size.height*rate, originalsize.width, size.height*rate);
                    
                    imageRef = CGImageCreateWithImageInRect([originalImage CGImage], rect);//获取图片整体部分
                }
                    break;
                    
                default:
                    break;
            }
            
            
        }
        else
        {
            //高度满足宽度需要裁剪
            switch (content) {
                case ClipContentLeft:
                {
                    CGRect rect =CGRectMake(0, 0, size.width*rate, originalsize.height);
                    
                    imageRef = CGImageCreateWithImageInRect([originalImage CGImage], rect);//获取图片整体部分
                    
                }
                    break;
                case ClipContentRight:
                {
                    CGRect rect =CGRectMake(originalsize.width-size.width*rate, 0, size.width*rate, originalsize.height);
                    
                    imageRef = CGImageCreateWithImageInRect([originalImage CGImage],rect );//获取图片整体部分
                }
                    break;
                    
                default:
                    break;
            }
            
            
        }
        UIImage *thumbScale = [UIImage imageWithCGImage:imageRef];
        CGImageRelease(imageRef);
        return thumbScale;
    }
    //原图长宽有一项大于标准长宽的，对大于标准的那一项进行裁剪，另一项保持不变
    else if(originalsize.height>size.height || originalsize.width>size.width)
    {
        CGImageRef imageRef = nil;
        if(originalsize.height>size.height)
        {
            switch (content) {
                case ClipContentTop:
                {
                    imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(0, 0, originalsize.width, size.height));//获取图片整体部分
                }
                    break;
                case ClipContentBottom:
                {
                    imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(0, originalsize.height-size.height, originalsize.width, size.height));//获取图片整体部分
                }
                    break;
                    
                default:
                    break;
            }
        }
        else if (originalsize.width>size.width)
        {
            //高度满足宽度需要裁剪
            switch (content) {
                case ClipContentLeft:
                {
                    imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(0, 0, size.width, originalsize.height));//获取图片整体部分
                    
                }
                    break;
                case ClipContentRight:
                {
                    imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(originalsize.width-size.width, 0, size.width, originalsize.height));//获取图片整体部分
                }
                    break;
                    
                default:
                    break;
            }
            
        }
        UIGraphicsBeginImageContext(originalsize);//指定要绘画图片的大小
        CGContextRef con = UIGraphicsGetCurrentContext();
        CGContextTranslateCTM(con, 0.0, originalsize.height);
        CGContextScaleCTM(con, 1.0, -1.0);
        CGContextDrawImage(con, CGRectMake(0, 0, originalsize.width, originalsize.height), imageRef);
        UIImage *standardImage = UIGraphicsGetImageFromCurrentImageContext();
        NSLog(@"改变后图片的宽度为%f,图片的高度为%f",[standardImage size].width,[standardImage size].height);
        UIGraphicsEndImageContext();
        CGImageRelease(imageRef);
        return standardImage;
    }
    //原图为标准长宽的，不做处理
    else
    {
        return originalImage;
    }
}
@end
