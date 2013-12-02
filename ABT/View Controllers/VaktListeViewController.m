//
//  VaktListeViewController.m
//  Arbeidstider
//
//  Created by Oscar Apeland on 10.09.13.
//  Copyright (c) 2013 Osc. All rights reserved.
//

#import "VaktListeViewController.h"
#import "ABTData.h"
#import "MNCalendarView.h"
#import "UIViewController+MJPopupViewController.h"
#import "MJDetailViewController.h"
#import "AwesomeMenu.h"
#import "DayDetailViewController.h"
#import "CalendarActionsheet.h"

@interface VaktListeViewController () <MNCalendarViewDelegate,CalendarASDelegate>
@property (nonatomic,strong) NSDateFormatter *dateFormatter;
@property (nonatomic,weak) UIImageView *infoImage;
@property (strong,nonatomic) MJDetailViewController *detailView;
@property (strong,nonatomic) NSArray *awesomeMenuItems;
@property (strong,nonatomic) MNCalendarView *calendarView;
@property (retain) NSArray *sheetArray;
@property NSString *actionSheetTitleString;
@property NSIndexPath *selectedIndexPath;
@end

@implementation VaktListeViewController
@synthesize sheetArray = _sheetArray;
#define kSheetAnimationTime 0.3f
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.calendarView = [[MNCalendarView alloc]initWithFrame:CGRectMake(0, 48, 320, 305)];
    self.calendarView.selectedDate = [NSDate date];
    self.calendarView.delegate = self;
    
    [self.view addSubview:self.calendarView];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Action sheet delegates
-(void)actionSheet:(CalendarActionsheet*)sheet selected:(NSString *)selected{
    
    if ([selected isEqualToString:@"Cancel"]) {
        
    }
    else if([selected isEqualToString:@"Yes"]){
        [self.calendarView addDotWithColor:[UIColor greenColor] atIndexPath:self.selectedIndexPath];
    }
    else if([selected isEqualToString:@"Maybe"]){
        [self.calendarView addDotWithColor:[UIColor orangeColor] atIndexPath:self.selectedIndexPath];
    }
    else if([selected isEqualToString:@"No"]){
        [self.calendarView addDotWithColor:[UIColor redColor] atIndexPath:self.selectedIndexPath];
    }
    
    [self showActionSheet:NO];

}
-(void)showActionSheet:(BOOL)show {
    
    BOOL didHidePrev = NO;
    CGRect screenRect = [[UIScreen mainScreen] bounds];

    for (CalendarActionsheet *actionSheet in self.view.subviews) {
        if ([actionSheet isKindOfClass:CalendarActionsheet.class]) {
                [UIView animateWithDuration:kSheetAnimationTime animations:^{
                [self.calendarView frameForPath:self.selectedIndexPath remove:YES];
                actionSheet.center = CGPointMake((screenRect.size.width/2),screenRect.size.height + actionSheet.bounds.size.height);
                } completion:^(BOOL finished){
                    [actionSheet removeFromSuperview];
                    if (!show) {
                        return;
                    }
                }];
            didHidePrev = YES;
            break;
            }
        }
    if (show){

        
        [self.calendarView frameForPath:self.selectedIndexPath remove:NO];
        float delay = 0;
        if (didHidePrev) {
            delay = 0.3f;
        }
        
        CalendarActionsheet *sheet = [[CalendarActionsheet alloc]initWithTitle:@"String"];
        sheet.delegate = self;
        sheet.center = CGPointMake((screenRect.size.width/2),screenRect.size.height + sheet.bounds.size.height/2);
        [self.view addSubview:sheet];
        
        [UIView animateWithDuration:kSheetAnimationTime delay:delay options:kNilOptions animations:^{
            sheet.center = CGPointMake((screenRect.size.width/2),screenRect.size.height - sheet.bounds.size.height/2-20);
        } completion:^(BOOL finished){}];}
}


#pragma mark - MNCalendar Delegates

- (void)calendarView:(MNCalendarView *)calendarView didLongPressDate:(NSDate *)date atIndex:(NSIndexPath *)indexPath{
    
    if (indexPath == self.selectedIndexPath) {
        return;
    }
    for (CalendarActionsheet *actionSheet in self.view.subviews) {
        if ([actionSheet isKindOfClass:CalendarActionsheet.class]) {
            [self.calendarView frameForPath:self.selectedIndexPath remove:YES];
        }
    }
    
    self.selectedIndexPath = indexPath;
    [self showActionSheet:YES];
}
- (void)calendarView:(MNCalendarView *)calendarView didSelectDate:(NSDate *)date atIndex:(NSIndexPath *)indexPath{
    [ABTData sharedData].currentDate = date;
    
    [self showActionSheet:NO];
    
    [self presentPopupViewController:[[DayDetailViewController alloc]init] animationType:MJPopupViewAnimationSlideBottomTop];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    dateFormatter.locale= [[NSLocale alloc] initWithLocaleIdentifier:[[NSLocale preferredLanguages]objectAtIndex:0]];
    dateFormatter.dateFormat = @"EEEE d. MMMM";
    NSString *logString = [[NSString alloc]init];
    
    if (![[[NSLocale preferredLanguages]objectAtIndex:0]isEqualToString:@"nb"]) {
        NSDateFormatter *prefixDateFormatter = [[NSDateFormatter alloc] init];
        [prefixDateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
        [prefixDateFormatter setDateFormat:@"EEEE MMMM d"];
        NSString *prefixDateString = [prefixDateFormatter stringFromDate:date];
        NSDateFormatter *monthDayFormatter = [[NSDateFormatter alloc] init];
        [monthDayFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
        [monthDayFormatter setDateFormat:@"d"];
        int date_day = [[monthDayFormatter stringFromDate:date] intValue];
        NSString *suffix_string = @"|st|nd|rd|th|th|th|th|th|th|th|th|th|th|th|th|th|th|th|th|th|st|nd|rd|th|th|th|th|th|th|th|st";
        NSArray *suffixes = [suffix_string componentsSeparatedByString: @"|"];
        NSString *suffix = [suffixes objectAtIndex:date_day];
        NSString *dateString = [prefixDateString stringByAppendingString:suffix];
        logString = dateString;
        
    }else{
        logString = [dateFormatter stringFromDate:date];
    }
    NSLog(@"Selected date: %@",logString);

}
-(void)dismissPopup{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideTopBottom];
    double delayInSeconds = 0.4f;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideTopBottom];

    });
    
}


@end