//
//  ABTData.m
//  Arbeidstider
//
//  Created by Oscar Apeland on 10.09.13.
//  Copyright (c) 2013 Osc. All rights reserved.
//

#import "ABTData.h"

@implementation ABTData

+(ABTData *)sharedData{
    static ABTData *sharedData = nil;
    if (!sharedData) {
        sharedData = [[super allocWithZone:nil]init];
    }
    return sharedData;
}

+(id)allocWithZone:(struct _NSZone *)zone
{
    return [self sharedData];
}
-(id)init
{
    self = [super init];
        if (self) {
        }
    return self;
}
@end