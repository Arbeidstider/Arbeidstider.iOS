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
    
    ABTPerson *person = [ABTData sharedData].currentPerson;
    self.nameLabel.text = person.name;
    self.ageLabel.text = [NSString stringWithFormat:@"%i",person.age];
    self.telNrLabel.text = person.telNumber;
    self.mailLabel.text = person.mailAdrs;
    self.positionLabel.text = person.workerClass;
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
