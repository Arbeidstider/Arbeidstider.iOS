//  FrontPageViewController.m
//  Arbeidstider
//
//  Created by Oscar Apeland on 09.09.13.
//  Copyright (c) 2013 Osc. All rights reserved.
//

#import "FrontPageViewController.h"
#import "ABTData.h"

@interface FrontPageViewController () <MZDayPickerDelegate,MZDayPickerDataSource,UIScrollViewDelegate>


@property (nonatomic,strong) NSDateFormatter *dateFormatter;
@property (weak, nonatomic) IBOutlet MZDayPicker *dayPicker;
@property (strong,nonatomic) NSMutableDictionary *params;
@property (strong) IBOutlet UIScrollView *timeLineScrollView;
@property CGSize screen;
@end

@implementation FrontPageViewController
@synthesize screen;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
}

-(void)viewWillLayoutSubviews{
    screen = self.view.bounds.size;
   
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    if (screen.height < self.timeLineScrollView.frame.size.height) {
        self.timeLineScrollView.bounds = CGRectMake(0, 0, 320, 370);
    }
    self.timeLineScrollView.delegate = self;
    self.timeLineScrollView.contentSize=CGSizeMake((self.timeLineScrollView.zoomScale*13)*24, self.timeLineScrollView.bounds.size.height);
    self.timeLineScrollView.contentSize = CGSizeMake(1000, self.timeLineScrollView.bounds.size.height);
    self.timeLineScrollView.minimumZoomScale=1.0;
    self.timeLineScrollView.maximumZoomScale=10.0;
    self.timeLineScrollView.zoomScale = 5.0;
    
    self.timeLineScrollView.backgroundColor = [UIColor redColor];
    // MZDAYPICKER SETUP
    self.dayPicker.hidden = NO;
    self.dayPicker.delegate = self;
    self.dayPicker.dataSource = self;
    self.dayPicker.month = 11;
    self.dayPicker.year = 2013;
    self.dayPicker.dayNameLabelFontSize = 12.0f;
    self.dayPicker.dayLabelFontSize = 18.0f;    
    [self.dayPicker setStartDate:[NSDate dateFromDay:1 month:9 year:2013] endDate:[NSDate dateFromDay:31 month:12 year:2013]];
    [self.dayPicker setCurrentDate:[NSDate date] animated:YES];
    
    [self makeTopBar];
    
    //Bra, stabil thirdpartyløsning
    self.params = [[NSMutableDictionary alloc]init];
    [self.params setObject:@"7" forKey:@"employeeID"];
    [self.params setObject:@"2013-09-13" forKey:@"startDate"];
    [self.params setObject:@"2013-09-30" forKey:@"endDate"];


    AFFNRequest *request = [AFFNRequest requestWithConnectionType:kAFFNGet andURL:@"http://services.arbeidstider.no/TimeSheetService/GetAllTimeSheets" andParams:_params withCompletion:^(AFFNCallbackObject *result){
        //Callback block for completion
        
        NSError *error = nil;
        //NSLog(@"Resultdata %@",result.data);
        NSJSONSerialization *response = [NSJSONSerialization JSONObjectWithData:result.data options:NSJSONReadingAllowFragments error:&error];
        NSMutableArray *JSONArray = [NSJSONSerialization JSONObjectWithData:result.data options:kNilOptions error:&error];//her er json lagra
        [ABTData sharedData].shifts = JSONArray;
        //NSLog(@"ABTData workdates = %@",[ABTData sharedData].shifts);
        
        for (NSDictionary *object in JSONArray) {
            NSString *string = [object objectForKey:@"ShiftEnd"];
            NSLog(@"%@",string);
        }
        
        if(error)
            //NSLog(@"Error: %@",error);
        
        //Data comes back as NSData so it's up to you to parse the response into whatever object type you need
        NSLog(@"Response: %@",response);
    } andFailure:^(NSError *error){
        //Callback block for failure
        NSLog(@"Error: %@",error);
        
    }];
    request = nil;
    //[[AFFNManager sharedManager] addNetworkOperation:request];
}
-(NSString*)convertDateToName:(NSDate*)date{
    
    NSString *returnString = [[NSString alloc]init];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale= [[NSLocale alloc] initWithLocaleIdentifier:[[NSLocale preferredLanguages]objectAtIndex:0]];
    dateFormatter.dateFormat = @"EEEE d. MMMM";
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
        returnString = dateString;
    }else{
        returnString = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:date]];
    }//Norsk return
    
    return returnString;
}

-(void)makeTopBar{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,HEADER_HEIGHT)];
    headerView.backgroundColor = [UIColor headerColor];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"Forside";
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
    [self.view addSubview:headerView];
    
}
- (void)menuButtonPressed{
    [self.sidePanelController showLeftPanelAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
#pragma mark - ScrollViewDelegate

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view{
    
}
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    NSLog(@"End:Scale %f",scale);
}
- (CGRect)zoomRectForScrollView:(UIScrollView *)scrollView withScale:(float)scale withCenter:(CGPoint)center {
    
    CGRect zoomRect;
    
    // The zoom rect is in the content view's coordinates.
    // At a zoom scale of 1.0, it would be the size of the
    // imageScrollView's bounds.
    // As the zoom scale decreases, so more content is visible,
    // the size of the rect grows.
    zoomRect.size.height = scrollView.frame.size.height / scale;
    zoomRect.size.width  = scrollView.frame.size.width  / scale;
    
    // choose an origin so as to get the right center.
    zoomRect.origin.x = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0);
    NSLog(@"%@",NSStringFromCGRect(zoomRect));
    return zoomRect;

}
#pragma mark - Daypickerdelegate
- (void)dayPicker:(MZDayPicker *)dayPicker willSelectDay:(MZDay *)day
{
    
}

- (void)dayPicker:(MZDayPicker *)dayPicker didSelectDay:(MZDay *)day
{
    ////////////////
}

@end