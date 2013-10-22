//
//  CalendarActionsheet.h
//  Arbeidstider
//
//  Created by Oscar Apeland on 18.10.13.
//  Copyright (c) 2013 Oscar Apeland. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CalendarActionsheet;
@protocol CalendarASDelegate;

@interface CalendarActionsheet : UIView
-(id)initWithTitle:(NSString *)string;
-(IBAction)cancelPressed:(id)sender;
-(IBAction)yesPressed:(id)sender;
-(IBAction)maybePressed:(id)sender;
-(IBAction)noPressed:(id)sender;

@property IBOutlet UIControl *yes;
@property IBOutlet UIControl *maybe;
@property IBOutlet UIControl *no;
@property IBOutlet UIControl *cancel;

@property(nonatomic,assign) id<CalendarASDelegate> delegate;


@end

@protocol CalendarASDelegate <NSObject>
@optional
- (void)actionSheet:(CalendarActionsheet*)sheet selected:(NSString*)selected;
@end
