//
//  ABTPerson.h
//  Arbeidstider
//
//  Created by Oscar Apeland on 03.10.13.
//  Copyright (c) 2013 Oscar Apeland. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ABTPerson : NSObject

@property (readwrite) NSString *name;
@property (readwrite) int age;
@property (readwrite) NSString *telNumber;
@property (readwrite) NSString *mailAdrs;
@property (readwrite) NSString *fbID;

-(id)initWithDict:(NSDictionary *)dict;

@end
