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
@interface SingleTon : NSObject
@property (strong,readwrite) SidePanelViewController*SideView;
@property (strong,readwrite) VaktListeViewController*VaktListeView;
@property (strong,readwrite) NSMutableArray *shifts;
@property (strong,readwrite) NSArray *workDates;

+(SingleTon*)Views;
+(SingleTon*)Shifts;
@end
