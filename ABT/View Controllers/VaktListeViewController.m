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
@interface VaktListeViewController () <MNCalendarViewDelegate>
@property (nonatomic,strong) NSDateFormatter *dateFormatter;
@property (nonatomic,weak) UIImageView *infoImage;
@property (strong,nonatomic) MJDetailViewController *detailView;
@property (strong,nonatomic) NSArray *awesomeMenuItems;
@property (strong,nonatomic) MNCalendarView *calendarView;
@end

@implementation VaktListeViewController

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
- (void)menuButtonPressed{
    [[SingleTon Views].SideView showLeftView];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)calendarView:(MNCalendarView *)calendarView didSelectDate:(NSDate *)date atIndex:(NSIndexPath *)indexPath{
    
    [SingleTon Shifts].currentDate = date;
    //[[SingleTon Views].SideView changeCenterPanel:@"DayDetail"];
    [self presentPopupViewController:[[DayDetailViewController alloc]init] animationType:MJPopupViewAnimationSlideBottomTop];
    /*NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm";
    
    NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    [dateFormatter setTimeZone:gmt];
    NSString *timeStamp = [dateFormatter stringFromDate:[NSDate date]];
    */
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    //NSLog(@"index: %@",[calendarView.collectionView cellForItemAtIndexPath:indexPath]);
    [calendarView addDotWithColor:[UIColor blackColor] atIndexPath:indexPath];
    [dateFormat setDateFormat:@"dd-MM-yyyy"];
    NSString *dateString = [dateFormat stringFromDate:date];
    NSLog(@"Selected date: %@",dateString);

}
-(void)dismissPopup{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideTopBottom];
}


@end
