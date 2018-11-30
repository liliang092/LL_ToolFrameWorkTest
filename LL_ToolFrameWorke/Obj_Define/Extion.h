//
//  Extion.h
//  FamilyDoctor
//
//  Created by markLi on 2018/10/31.
//  Copyright © 2018 pan. All rights reserved.
//

#ifndef Extion_h
#define Extion_h

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define APPDELEGATE                         (AppDelegate *)[UIApplication sharedApplication].delegate
#define GlobalIphone6Height 667.0
#define GlobalIphone6Width 375.0
#define MEDUMFONTSize(fontSize) [UIFont fontWithName:@"Avenir next medium" size:fontSize]
#define NAVFONT MEDUMFONTSize(18)
#define BaseFontColor [UIColor darkGrayColor]

#define State

// 屏幕的宽
#define ScreenWidth                         [[UIScreen mainScreen] bounds].size.width
// 屏幕的高
#define ScreenHeight                        [[UIScreen mainScreen] bounds].size.height

#define ConversionHeightFrom(a) ScreenHeight / (GlobalIphone6Height / a)
#define ConversionWidthFrom(a) ScreenWidth / (GlobalIphone6Width / a)

#define ConstConversionHeightFrom(a,b) a / (GlobalIphone6Height / b);
#define ConstConversionWidthFrom(a,b) a / (GlobalIphone6Width / b);


#endif /* Extion_h */
