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
#import "JLActionSheet.h"

@interface VaktListeViewController () <MNCalendarViewDelegate,JLActionSheetDelegate>
@property (nonatomic,strong) NSDateFormatter *dateFormatter;
@property (nonatomic,weak) UIImageView *infoImage;
@property (strong,nonatomic) MJDetailViewController *detailView;
@property (strong,nonatomic) NSArray *awesomeMenuItems;
@property (strong,nonatomic) MNCalendarView *calendarView;
@property (strong,nonatomic) JLActionSheet *actionSheet;
@property (retain) NSArray *sheetArray;
@property NSString *actionSheetTitleString;
@property NSIndexPath *selectedInteger;
@end

@implementation VaktListeViewController
@synthesize sheetArray = _sheetArray;
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

    self.actionSheet = [JLActionSheet sheetWithTitle:@"Status..." delegate:self cancelButtonTitle:@"Avbryt" otherButtonTitles:[NSArray arrayWithObjects: @"Kan", @"Helst ikke", @"Kan ikke", nil]];
    [self.actionSheet allowTapToDismiss:YES];
    
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




#pragma mark - JLActionSheet Delegates
-(void)actionSheet:(JLActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"%ld",(long)buttonIndex);
    switch (buttonIndex) {
        case 3:
            [self.calendarView addDotWithColor:[UIColor greenColor] atIndexPath:self.selectedInteger];
            break;
        case 2:
            [self.calendarView addDotWithColor:[UIColor orangeColor] atIndexPath:self.selectedInteger];
            break;
        case 1:
            [self.calendarView addDotWithColor:[UIColor redColor] atIndexPath:self.selectedInteger];
            break;
        case 0:
            break;
        default:
            break;
    }
    
}
-(void)actionSheet:(JLActionSheet *)actionSheet didDismissButtonAtIndex:(NSInteger)buttonIndex{
    
}


#pragma mark - MNCalendar Delegates

- (void)calendarView:(MNCalendarView *)calendarView didLongPressDate:(NSDate *)date atIndex:(NSIndexPath *)indexPath{
    self.selectedInteger = indexPath;
    [self.actionSheet showInView:self.view];
}
- (void)calendarView:(MNCalendarView *)calendarView didSelectDate:(NSDate *)date atIndex:(NSIndexPath *)indexPath{
    
    [SingleTon Shifts].currentDate = date;
    //[[SingleTon Views].SideView changeCenterPanel:@"DayDetail"];
    [self presentPopupViewController:[[DayDetailViewController alloc]init] animationType:MJPopupViewAnimationSlideBottomTop];
    [calendarView addDotWithColor:[UIColor blackColor] atIndexPath:indexPath];
    
    
    
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
    NSLog(@"dismiss");
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideTopBottom];
}


@end