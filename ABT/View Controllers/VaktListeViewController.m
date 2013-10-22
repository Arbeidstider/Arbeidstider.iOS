//
//  VaktListeViewController.m
//  Arbeidstider
//
//  Created by Oscar Apeland on 10.09.13.
//  Copyright (c) 2013 Osc. All rights reserved.
//

#import "VaktListeViewController.h"
#import "SingleTon.h"
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
    [self makeTopBar];
    self.calendarView = [[MNCalendarView alloc]initWithFrame:CGRectMake(0, 48, 320, 305)];
    self.calendarView.selectedDate = [NSDate date];
    self.calendarView.delegate = self;
    
    [self.view addSubview:self.calendarView];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [SingleTon Views].VaktListeView = self;
    });
}
-(void)makeTopBar{
    self.detailView = [[MJDetailViewController alloc]init];
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,HEADER_HEIGHT)];
    headerView.backgroundColor = [UIColor colorWithRed:43.0/255 green:45.0/255 blue:48.0/255 alpha:1];
    
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"Vaktliste";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.frame = CGRectMake(0, 0, self.view.bounds.size.width, HEADER_HEIGHT);
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    titleLabel.font = [UIFont fontWithName:THIN size:HEADER_FONT_SIZE];
    [headerView addSubview:titleLabel];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self
               action:@selector(menuButtonPressed)
     forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    button.frame = CGRectMake(5.0, 5.0, 40.0, 40.0);
    
    [headerView addSubview:button];
    UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [infoButton addTarget:self
                   action:@selector(infoPressed)
         forControlEvents:UIControlEventTouchUpInside];
    [infoButton setImage:[UIImage imageNamed:@"infoIcon.png"] forState:UIControlStateNormal];
    infoButton.frame = CGRectMake(270.0, 5.0, 45.0, 40.0);
    [headerView addSubview:infoButton];
    [self.view addSubview:headerView];
}


-(void)infoPressed{
    [self presentPopupViewController:self.detailView animationType:MJPopupViewAnimationFade];
}
-(void)menuButtonPressed{
    [[SingleTon Views].SideView showLeftView];
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
    
    for (CalendarActionsheet *actionSheet in self.view.subviews) {
        if ([actionSheet isKindOfClass:CalendarActionsheet.class]) {
                [UIView animateWithDuration:kSheetAnimationTime animations:^{
                [self.calendarView frameForPath:self.selectedIndexPath remove:YES];
                actionSheet.center = CGPointMake((self.view.frame.size.width/2),self.view.frame.size.height + actionSheet.frame.size.height);
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
        sheet.center = CGPointMake((self.view.frame.size.width/2),self.view.frame.size.height + sheet.bounds.size.height/2);
        [self.view addSubview:sheet];
        [UIView animateWithDuration:kSheetAnimationTime delay:delay options:kNilOptions animations:^{
            sheet.center = CGPointMake((self.view.frame.size.width/2),self.view.frame.size.height - sheet.bounds.size.height/2-20);
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
    [SingleTon Shifts].currentDate = date;
    
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