//
//  ObjcHelper.m
//  LSExtensions
//
//  Created by 이영준 on 2018. 7. 17..
//  Copyright © 2018년 leesam. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "ObjcHelper.h"
//#import "siwonlectureroom-Bridging-Header.h"

@implementation ObjcHelper

+ (id)catch:(id(^)(void))block error:(__autoreleasing NSError **)error{
    @try{
        id result = block();
        return result;
    }@catch (NSException *exception){
        if(error){
            *error = [[NSError alloc] initWithDomain:exception.name code:0 userInfo: exception.userInfo];
        }
    }
    return nil;
}

@end
