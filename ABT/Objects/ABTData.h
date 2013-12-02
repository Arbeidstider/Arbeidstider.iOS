//
//  SingleTon.h
//  Arbeidstider
//
//  Created by Oscar Apeland on 10.09.13.
//  Copyright (c) 2013 Osc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SidePanelViewController.h"
#import "VaktListeViewController.h"
#import "PersonViewController.h"
#import "ABTPerson.h"

@interface ABTData : NSObject


@property (strong,readwrite) NSMutableArray *shifts;

@property (strong,readwrite) NSMutableArray *allPersons;
@property (strong,readwrite) NSArray *workDates;
@property (readwrite,retain) NSDate *currentDate;
@property (readwrite,retain) ABTPerson *currentPerson;
@property (readwrite) NSInteger *currentIndex;

+(ABTData*)sharedData;

@end
