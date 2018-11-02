//
//  LYH_LogConstant.h
//  NTES_IM_CocoaPods
//
//  Created by lee on 2018/11/1.
//  Copyright © 2018年 lee. All rights reserved.
//

#ifndef LYH_LogConstant_h
#define LYH_LogConstant_h

#pragma mark ------------------------ 日志输出 ------------------------


// 解决Xcode8 log问题
#ifdef DEBUG
#define YHLog(format, ...) printf("类名: < %p %s:(%d) > \n方法名: %s \n打印内容是:\n%s\n", self, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String] )
#else
#define YHLog(format, ...)
#endif

#endif /* LYH_LogConstant_h */
