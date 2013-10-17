//
//  DayDetailViewController.m
//  Arbeidstider
//
//  Created by Oscar Apeland on 02.10.13.
//  Copyright (c) 2013 Oscar Apeland. All rights reserved.
//

#import "DayDetailViewController.h"
#import "SingleTon.h"
#import "MJDetailViewController.h"
@interface DayDetailViewController ()

@end

@implementation DayDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self makeTopBar];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)makeTopBar{
    NSDate *date = [SingleTon Shifts].currentDate;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    dateFormatter.locale= [[NSLocale alloc] initWithLocaleIdentifier:[[NSLocale preferredLanguages]objectAtIndex:0]];
    dateFormatter.dateFormat = @"EEEE d. MMMM";
    NSString *labelString = [[NSString alloc]init];
    
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
        labelString = dateString;
        
    }else{
        labelString = [dateFormatter stringFromDate:date];
    }
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,HEADER_HEIGHT)];
    headerView.backgroundColor = [UIColor colorWithRed:43.0/255 green:45.0/255 blue:48.0/255 alpha:1];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = labelString;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.frame = CGRectMake(0, 0, self.view.bounds.size.width, HEADER_HEIGHT);
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    titleLabel.font = [UIFont fontWithName:THIN size:HEADER_FONT_SIZE-10];
    [headerView addSubview:titleLabel];
    
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneButton addTarget:self
                   action:@selector(menuButtonPressed)
         forControlEvents:UIControlEventTouchUpInside];
    [doneButton setImage:[UIImage imageNamed:@"doneIcon.png"] forState:UIControlStateNormal];
    doneButton.frame = CGRectMake(270.0, 5.0, 45.0, 40.0);
    [headerView addSubview:doneButton];
    
    [self.view addSubview:headerView];
}


- (void)menuButtonPressed{
    NSLog(@"pressed");
    [[SingleTon Views].VaktListeView dismissPopup];
    //[[SingleTon Views].SideView showLeftView];
}

@end
