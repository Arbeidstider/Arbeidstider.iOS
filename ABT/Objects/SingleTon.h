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
@interface SingleTon : NSObject
@property (strong,readwrite) SidePanelViewController*SideView;
@property (strong,readwrite) VaktListeViewController*VaktListeView;
@property (strong,readwrite) PersonViewController *PersonView;
@property (strong,readwrite) NSMutableArray *shifts;
@property (strong,readwrite) NSMutableArray *allPersons;
@property (strong,readwrite) NSArray *workDates;
@property (readwrite,retain) NSDate *currentDate;
@property (readwrite,retain) ABTPerson *currentPerson;

+(SingleTon*)Views;
+(SingleTon*)Shifts;

@end
