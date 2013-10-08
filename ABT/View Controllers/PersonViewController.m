//
//  PersonViewController.m
//  Arbeidstider
//
//  Created by Oscar Apeland on 09.09.13.
//  Copyright (c) 2013 Osc. All rights reserved.
//

#import "PersonViewController.h"
#import "ABTPerson.h"

@interface PersonViewController ()
@end

@implementation PersonViewController

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
    
    NSString* pathToFile = [[NSBundle mainBundle] pathForResource:@"json" ofType: @"txt"];
    NSString *file = [[NSString alloc] initWithContentsOfFile:pathToFile encoding:  NSUTF8StringEncoding error:NULL];
    NSData *jsonData = [file dataUsingEncoding:NSUTF8StringEncoding];
    NSError *e;
    NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&e];
    NSMutableArray *mtbArray = [[NSMutableArray alloc]init];
    for (NSDictionary *dictionary in array) {
        ABTPerson *person = [[ABTPerson alloc]initWithDict:dictionary];
        [mtbArray addObject:person];
    }
    [SingleTon Shifts].allPersons = mtbArray;
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)makeTopBar{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,HEADER_HEIGHT)];
    headerView.backgroundColor = [UIColor colorWithRed:43.0/255 green:45.0/255 blue:48.0/255 alpha:1];
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"Personer";
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
    [[SingleTon Views].SideView showLeftView];
}
@end
