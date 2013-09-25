//  FrontPageViewController.m
//  Arbeidstider
//
//  Created by Oscar Apeland on 09.09.13.
//  Copyright (c) 2013 Osc. All rights reserved.
//

#import "FrontPageViewController.h"
#import "SingleTon.h"

@interface FrontPageViewController () <MZDayPickerDelegate,MZDayPickerDataSource>
@property (nonatomic,strong) NSDateFormatter *dateFormatter;
@property (weak, nonatomic) IBOutlet UILabel *selectedLabel;
@property (weak, nonatomic) IBOutlet MZDayPicker *dayPicker;
@property (strong,nonatomic)NSMutableDictionary *params;

@end

@implementation FrontPageViewController
//#define kLatestKivaLoansURL [NSURL URLWithString:@"http://api.kivaws.org/v1/loans/search.json?status=fundraising"] //2

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

    // MZDAYPICKER SETUP
    self.selectedLabel.font = [UIFont fontWithName:THIN size:12.0f];
    self.dayPicker.delegate = self;
    self.dayPicker.dataSource = self;
    self.dayPicker.month = 9;
    self.dayPicker.year = 2013;
    self.dayPicker.dayNameLabelFontSize = 10.0f;
    self.dayPicker.dayLabelFontSize = 18.0f;    
//    [self.dayPicker setActiveDaysFrom:1 toDay:30];
    
    
    [self.dayPicker setStartDate:[NSDate dateFromDay:1 month:9 year:2013] endDate:[NSDate dateFromDay:31 month:10 year:2013]];
    [self.dayPicker setCurrentDate:[NSDate date] animated:NO];
    
    [self makeTopBar];
    
    //Bra, stabil thirdpartyløsning
    self.params = [[NSMutableDictionary alloc]init];
    [self.params setObject:@"1" forKey:@"employerID"];
    [self.params setObject:@"2013-09-13" forKey:@"startDate"];
    [self.params setObject:@"2013-09-15" forKey:@"endDate"];
    AFFNRequest *request = [AFFNRequest requestWithConnectionType:kAFFNGet andURL:@"http://services.arbeidstider.no/TimeSheetService/GetAllTimeSheets" andParams:_params withCompletion:^(AFFNCallbackObject *result){
        //Callback block for completion
        
        NSError *error = nil;
        
        //NSJSONSerialization *response = [NSJSONSerialization JSONObjectWithData:result.data options:NSJSONReadingAllowFragments error:&error];
        /*NSMutableArray *JSONArray = [NSJSONSerialization JSONObjectWithData:result.data options:kNilOptions error:&error];//her er json lagra
        [SingleTon Shifts].shifts = JSONArray;
        NSLog(@"Singleton workdates = %@",[SingleTon Shifts].shifts);
        
        for (NSDictionary *object in JSONArray) {
            NSString *string = [object objectForKey:@"ShiftEnd"];
            NSLog(@"%@",string);
        }*/
        
        if(error)
            NSLog(@"Error: %@",error);
        
        //Data comes back as NSData so it's up to you to parse the response into whatever object type you need
        //NSLog(@"Response: %@",response);
    } andFailure:^(NSError *error){
        //Callback block for failure
        NSLog(@"Error: %@",error);
        
    }];
    
    [[AFFNManager sharedManager] addNetworkOperation:request];
}

-(void)makeTopBar{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,HEADER_HEIGHT)];
    headerView.backgroundColor = [UIColor colorWithRed:43.0/255 green:45.0/255 blue:48.0/255 alpha:1];
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"Forside";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.frame = CGRectMake(128, 12, 80 , 21);
    titleLabel.font = [UIFont fontWithName:THIN size:20.0f];
    [headerView addSubview:titleLabel];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self
               action:@selector(menuButtonPressed)
     forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    button.frame = CGRectMake(5.0, 5.0, 40.0, 40.0);
    
    [headerView addSubview:button];
    [self.view addSubview:headerView];
    
    
}


- (void)menuButtonPressed{
    [[SingleTon Views].SideView showLeftView];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Daypickerdelegate
- (void)dayPicker:(MZDayPicker *)dayPicker willSelectDay:(MZDay *)day
{
}

- (void)dayPicker:(MZDayPicker *)dayPicker didSelectDay:(MZDay *)day
{
    NSLog(@"Did select day %@",day.date);

    self.selectedLabel.text = [NSString stringWithFormat:@"Selected day: %@",day.date];
    
  
    
}

@end