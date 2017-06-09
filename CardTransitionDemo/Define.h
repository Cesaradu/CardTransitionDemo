//
//  Define.h
//  CardTransitionDemo
//
//  Created by hztuen on 2017/6/9.
//  Copyright © 2017年 cesar. All rights reserved.
//

#ifndef Define_h
#define Define_h

//屏幕宽高
#define ScreenHeight    [[UIScreen mainScreen] bounds].size.height
#define ScreenWidth     [[UIScreen mainScreen] bounds].size.width
#define Width           self.view.frame.size.width
#define Height          self.view.frame.size.height

/**
 适配 给定4.7寸屏尺寸，适配4和5.5寸屏尺寸
 */
#define Suit55Inch           1.104
#define Suit4Inch            1.171875

/**
 适配 给定5.5寸屏尺寸，适配4和4.7寸屏尺寸
 */
//#define Suit47Inch           1.104
//#define Suit4Inch            1.29375

// 系统判定
#define IOS_VERSION    [[[UIDevice currentDevice]systemVersion]floatValue]
#define IS_IOS8        (IOS_VERSION>=8.0)
#define IS_IOS7        (IOS_VERSION>=7.0)
#define Is_IOS9        (IOS_VERSION>=9.0 && IOS_VERSION<10)

// 屏幕判定
#define IS_IPHONE35INCH  ([SDiPhoneVersion deviceSize] == iPhone35inch ? YES : NO)//4, 4S
#define IS_IPHONE4INCH  ([SDiPhoneVersion deviceSize] == iPhone4inch ? YES : NO)//5, 5C, 5S, SE
#define IS_IPHONE47INCH  ([SDiPhoneVersion deviceSize] == iPhone47inch ? YES : NO)//6, 6S, 7
#define IS_IPHONE55INCH ([SDiPhoneVersion deviceSize] == iPhone55inch ? YES : NO)//6P, 6SP, 7P


#endif /* Define_h */
