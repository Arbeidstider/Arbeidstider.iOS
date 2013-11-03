//
//  ProfileViewController.m
//  Arbeidstider
//
//  Created by Oscar Apeland on 10.10.13.
//  Copyright (c) 2013 Oscar Apeland. All rights reserved.
//

#import "ProfileViewController.h"
#import "MJDetailViewController.h"
#import "UIViewController+MJPopupViewController.h"
#import "ABTPerson.h"
@interface ProfileViewController ()
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *ageLabel;
@property (strong, nonatomic) IBOutlet UILabel *mailLabel;
@property (strong, nonatomic) IBOutlet UILabel *telNrLabel;
@property (strong, nonatomic) IBOutlet UILabel *positionLabel;


@end

@implementation ProfileViewController
@synthesize nameLabel = _nameLabel;
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
    
    ABTPerson *person = [ABTData sharedData].currentPerson;
    self.nameLabel.text = person.name;
    self.ageLabel.text = [NSString stringWithFormat:@"%i",person.age];
    self.telNrLabel.text = person.telNumber;
    self.mailLabel.text = person.mailAdrs;
    self.positionLabel.text = person.workerClass;
    
	// Do any additional setup after loading the view.
}
-(void)makeTopBar{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,HEADER_HEIGHT)];
    headerView.backgroundColor = [UIColor colorWithRed:43.0/255 green:45.0/255 blue:48.0/255 alpha:1];
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = [ABTData sharedData].currentPerson.name;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.frame = CGRectMake(0, 0, self.view.bounds.size.width, HEADER_HEIGHT);
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    titleLabel.font = [UIFont fontWithName:THIN size:HEADER_FONT_SIZE];
    if (titleLabel.text.length > 15) {
        titleLabel.font = [UIFont fontWithName:THIN size:HEADER_FONT_SIZE-10];
    }
    [headerView addSubview:titleLabel];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self
               action:@selector(menuButtonPressed)
     forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"doneIcon.png"] forState:UIControlStateNormal];
    button.frame =CGRectMake(270.0, 5.0, 45.0, 40.0);
    
    [headerView addSubview:button];
    [headerView bringSubviewToFront:button];
    [self.view addSubview:headerView];
    
}
- (void)menuButtonPressed{
    [[ABTData sharedData].PersonView dismissPopup];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
