//
//  ABTPerson.h
//  Arbeidstider
//
//  Created by Oscar Apeland on 03.10.13.
//  Copyright (c) 2013 Oscar Apeland. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ABTPerson : NSObject

@property (readwrite,retain) NSString *name;
@property (readwrite) int age;
@property (readwrite,retain) NSString *telNumber;
@property (readwrite,retain) NSString *mailAdrs;
@property (readwrite,retain) NSString *fbID;
@property (readwrite,retain) NSString *workerClass;

-(id)initWithDict:(NSDictionary *)dict;
@end