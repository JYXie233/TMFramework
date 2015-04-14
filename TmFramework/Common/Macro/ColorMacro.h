//
//  ColorMacro.h
//  TmFramework
//
//  Created by Tom on 15/4/12.
//  Copyright (c) 2015年 Tom. All rights reserved.
//

#ifndef TmFramework_ColorMacro_h
#define TmFramework_ColorMacro_h
//带有RGBA的颜色设置
#define RGBA(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

#define RGB(R, G, B) RGBA(R, G, B, 1.0)

#endif
