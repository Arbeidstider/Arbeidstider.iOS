//
//  SidePanelViewController.m
//  Arbeidstider
//
//  Created by Oscar Apeland on 09.09.13.
//  Copyright (c) 2013 Osc. All rights reserved.
//

#import "SidePanelViewController.h"
#import "ABTData.h"
@interface SidePanelViewController ()

@end

@implementation SidePanelViewController

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
   
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) awakeFromNib
{
    [self setLeftPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"leftViewController"]];
    [self setCenterPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"Forside"]];
}

@end
