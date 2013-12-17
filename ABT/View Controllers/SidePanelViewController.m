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
    
    UIColor * barColor = [UIColor headerColor];
    
    
    if([self.navigationController.navigationBar respondsToSelector:@selector(setBarTintColor:)]){
        [self.navigationController.navigationBar setBarTintColor:barColor];
    }
    else {
        [self.navigationController.navigationBar setTintColor:barColor];
    }
    
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor whiteColor], NSForegroundColorAttributeName,
                                                           
                                                           [UIFont fontWithName:@"HelveticaNeue-Light" size:26.0], NSFontAttributeName, nil]];
    
    UIBarButtonItem *flipButton = [[UIBarButtonItem alloc]initWithImage:nil style:UIBarButtonItemStylePlain target:self action:@selector(showLeftPanelAnimated:)];
    flipButton = [self leftButtonForCenterPanel];
    self.navigationItem.leftBarButtonItem = flipButton;
    
    self.navigationItem.title = @"Forside";

}

@end
