//
//  ABTPerson.m
//  Arbeidstider
//
//  Created by Oscar Apeland on 03.10.13.
//  Copyright (c) 2013 Oscar Apeland. All rights reserved.
//

#import "ABTPerson.h"

@implementation ABTPerson
-(id)initWithDict:(NSDictionary*)dict{
    self = [super init];
    if(self){
        self.name = [dict objectForKey:@"name"];
        self.age = [[dict objectForKey:@"age"]intValue];
        self.fbID = [dict objectForKey:@"fbID"];
        self.telNumber = [dict objectForKey:@"number"];
        self.mailAdrs = [dict objectForKey:@"mailAdrs"];
        self.workerClass = [dict objectForKey:@"class"];
    }
    return self;
}

@end
