//
//  NSDictionary+LYH_JSONLog.h
//  LYH_EducationOnLive
//
//  Created by lee on 2018/8/23.
//  Copyright © 2018年 DCloud. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (LYH_JSONLog)

/**
 将一个字典json 转换 字符串的json
 @return 返回json格式的log
 */
- (NSString *)lyh_jsonLog_descriptionWithLocale:(nullable id)locale;
@end
