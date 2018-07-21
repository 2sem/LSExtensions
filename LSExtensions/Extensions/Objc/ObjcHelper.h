//
//  ObjcHelper.h
//  LSExtensions
//
//  Created by 이영준 on 2018. 7. 17..
//  Copyright © 2018년 leesam. All rights reserved.
//
#import <Foundation/Foundation.h>

#ifndef ObjcHelper_h
#define ObjcHelper_h

@interface ObjcHelper: NSObject
+ (id)catch:(id(^)(void))block error:(__autoreleasing NSError **)error;

@end

#endif /* ObjcHelper_h */
