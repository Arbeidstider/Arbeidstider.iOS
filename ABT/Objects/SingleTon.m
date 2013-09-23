//
//  SingleTon.m
//  Arbeidstider
//
//  Created by Oscar Apeland on 10.09.13.
//  Copyright (c) 2013 Osc. All rights reserved.
//

#import "SingleTon.h"

@implementation SingleTon
+(SingleTon *)Views{
    static SingleTon *Views = nil;
    if (!Views) {
        Views = [[super allocWithZone:nil]init];
    }
    return Views;
}
+(SingleTon*)Shifts{
    static SingleTon *Shifts = nil;
    if (!Shifts) {
        Shifts = [[super allocWithZone:nil]init];
    }
    return Shifts;
}
+(id)allocWithZone:(struct _NSZone *)zone
{
    return [self Views];
    return [self Shifts];
}
-(id)init
{
    self = [super init];
        if (self) {
            
            
            
            
        }
    return self;
}
@end