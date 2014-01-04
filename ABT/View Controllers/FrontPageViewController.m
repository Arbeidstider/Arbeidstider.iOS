//  FrontPageViewController.m
//  Arbeidstider
//
//  Created by Oscar Apeland on 09.09.13.
//  Copyright (c) 2013 Osc. All rights reserved.
//

#import "FrontPageViewController.h"
#import "ABTData.h"
#import "TimeLineView.h"
@interface FrontPageViewController () <MZDayPickerDelegate,MZDayPickerDataSource,UIScrollViewDelegate>


@property (nonatomic,strong) NSDateFormatter *dateFormatter;
@property (weak, nonatomic) IBOutlet MZDayPicker *dayPicker;
@property (strong,nonatomic) NSMutableDictionary *params;
@property (strong) UIScrollView *timeLineScrollView;
@property CGSize screen;
@property TimeLineView *timeLineView;

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
    self.timeLineView = [[TimeLineView alloc]initWithFrame:CGRectMake(0, 0, 2400, 438)];
    self.timeLineScrollView = [[UIScrollView alloc]init];
    self.timeLineScrollView.frame = CGRectMake(0, 130, 320, 438);
    self.timeLineScrollView.delegate = self;
    
    self.timeLineScrollView.contentSize = CGSizeMake(2400,self.timeLineScrollView.frame.size.height);
    self.timeLineScrollView.showsVerticalScrollIndicator = NO;
    self.timeLineScrollView.bounces = NO;
    
    
    self.timeLineScrollView.minimumZoomScale=1.0;
    self.timeLineScrollView.maximumZoomScale=10.0;
    self.timeLineScrollView.zoomScale = 1.0;
    [self.timeLineScrollView addSubview:self.timeLineView];
    [self.view addSubview:self.timeLineScrollView];
    
    
    // MZDAYPICKER SETUP
    self.dayPicker.hidden = NO;
    self.dayPicker.delegate = self;
    self.dayPicker.dataSource = self;
    self.dayPicker.month = 11;
    self.dayPicker.year = 2013;
    self.dayPicker.dayNameLabelFontSize = 12.0f;
    self.dayPicker.dayLabelFontSize = 18.0f;    
    [self.dayPicker setStartDate:[NSDate dateFromDay:1 month:9 year:2011] endDate:[NSDate dateFromDay:31 month:12 year:2015]];
    [self.dayPicker setCurrentDate:[NSDate date] animated:YES];
   
    //Bra, stabil thirdpartyløsning
    self.params = [[NSMutableDictionary alloc]init];
    [self.params setObject:@"62560772-CFD8-4DDB-8CE3-3F37638C4327" forKey:@"UserID"];
    [self.params setObject:@"2013,9,1" forKey:@"StartDate"];
    [self.params setObject:@"2013,12,31" forKey:@"EndDate"];

    AFFNRequest *request = [AFFNRequest requestWithConnectionType:kAFFNGet andURL:@"http://services.arbeidstider.no/timesheets" andParams:_params withCompletion:^(AFFNCallbackObject *result){
        //Callback block for completion
        
        NSError *error = nil;
        NSMutableArray *JSONArray = [NSJSONSerialization JSONObjectWithData:result.data options:kNilOptions error:&error];//her er json lagra
        [ABTData sharedData].shifts = JSONArray;
        NSLog(@"ABTData workdates = %@",[ABTData sharedData].shifts);
        
        if(error)NSLog(@"Error: %@",error);
        
        //Data comes back as NSData so it's up to you to parse the response into whatever object type you need
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
#pragma mark - ScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.timeLineView;
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view{
    NSLog(@"began zooming");
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    scrollView.transform = CGAffineTransformIdentity;
    [self redrawContentInTimeLine:scale];
    
    [view setContentScaleFactor:scale];
    
   
}

-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
    NSLog(@"didzoom %f",scrollView.zoomScale);
}

-(void)redrawContentInTimeLine:(float)scale{
    
}

#pragma mark - Daypickerdelegate
- (void)dayPicker:(MZDayPicker *)dayPicker willSelectDay:(MZDay *)day
{
    
}

- (void)dayPicker:(MZDayPicker *)dayPicker didSelectDay:(MZDay *)day
{
    NSLog(@"%@",[self convertDateToName:day.date]);
    ////////////////
}

@end