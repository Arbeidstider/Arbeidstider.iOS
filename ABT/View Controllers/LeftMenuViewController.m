//
//  LeftMenuViewController.m
//  Arbeidstider
//
//  Created by Oscar Apeland on 09.09.13.
//  Copyright (c) 2013 Osc. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "SidePanelViewController.h"
#import "ABTData.h"
#import "ABTMenuCell.h"

@interface LeftMenuViewController ()
{
    
}

@property (retain) NSArray *viewsArray;
@property (retain) NSArray *imagesArray;
@property NSMutableArray *allControls;

@end

@implementation LeftMenuViewController

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
    [self menuShow];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuShow) name:@"menuShow" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuHide) name:@"menuHide" object:nil];

    _viewsArray = [[NSArray alloc]initWithObjects:@"Forside",@"Dine Vakter",@"Oppslag",@"Personer",@"Penger",@"Innstillinger", nil];
    
    _imagesArray = [[NSArray alloc]initWithObjects:@"frontpage.png",@"vakter.png",@"oppslag.png",@"personer",@"penger.png",@"innstillinger.png",nil];
    

    
}
-(void)menuItemSelected:(id)sender{
    
    [self colorMenuIcon:sender isSelected:MenuItemHighlighted];
    
}

-(void)menuItemNoLongerSelected:(id)sender{
    
    [self colorMenuIcon:sender isSelected:MenuItemNormal];
}
-(void)menuShow{
    for (UIControl*control in self.view.subviews) {
        [control removeFromSuperview];
    }
    
    self.allControls = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < self.viewsArray.count; i++) {
        
        int p = 70;
        if (self.view.frame.size.height == 480) {
            p = 40;
        }
        UIControl *menuItem = [[UIControl alloc]initWithFrame:CGRectMake(40, i*75+p, 200, 55)];
        [menuItem addTarget:self action:@selector(menuItemPressed:) forControlEvents:UIControlEventTouchUpInside];
        [menuItem addTarget:self action:@selector(menuItemSelected:) forControlEvents:UIControlEventTouchDown];
        [menuItem addTarget:self action:@selector(menuItemNoLongerSelected:) forControlEvents:UIControlEventTouchDragOutside];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(80,15, 70, 20)];
        label.text = [self.viewsArray objectAtIndex:i];
        label.textColor = [UIColor whiteColor];
        
        
        label.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20];
        [label sizeToFit];
        [menuItem addSubview:label];
        
        [self.view addSubview:menuItem];
        if ((int)[ABTData sharedData].currentIndex == i) {
            label.textColor = label.textColor = [UIColor whiteColor];
            [self colorMenuIcon:menuItem isSelected:MenuItemSelected];
            
        }
        [self.allControls addObject:menuItem];
        
        
        
        
        
    }
    /*
    float animtime =0;
    for (UIControl*view in self.allControls) {
        
        [UIView animateWithDuration:0.45f delay:animtime usingSpringWithDamping:0.8f initialSpringVelocity:1.3f options:kNilOptions animations:^(void){
            view.frame = CGRectMake(20, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
        } completion:^(BOOL finished){ }];
        animtime +=0.075;
    }*/
    
    double delayInSeconds = 0.175f;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){

        [self hideTopBar];});
}

-(void)hideTopBar{
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
-(void)showTopBar{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)menuHide{
    for (id control in self.allControls) {
        
        [control removeFromSuperview];
        
    }
    double delayInSeconds = 0.15f;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self showTopBar];
    });
    }

-(void)menuItemPressed:(id)sender{
    NSString *correctName;
    [self colorMenuIcon:sender isSelected:MenuItemSelected];
    
    for (UIControl*control in self.allControls) {
        
        BOOL correct = NO;
        if (control == sender) {
            correct = YES;
            [ABTData sharedData].currentIndex = (NSInteger*)[self.allControls indexOfObject:control];
        }
        for (UILabel*label in control.subviews) {
            if ([label isKindOfClass:[UILabel class]]) {
                if (correct) {
                    correctName = label.text;
                }
                else {label.textColor = [UIColor whiteColor];
                    [self colorMenuIcon:control isSelected:MenuItemNormal];
                }
                
            }
            
        }
        
    }
    for (UIControl*view in self.allControls) {
        
        [UIView animateWithDuration:0.15f delay:0 usingSpringWithDamping:0.65f initialSpringVelocity:1.7f options:kNilOptions animations:^(void){
            view.frame = CGRectMake(-200, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
        } completion:^(BOOL finished){if(!finished){} }];
    }
    
    double delayInSeconds = 0.15f;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self switchToViewController:correctName];
    });
    
    
}

-(void)switchToViewController:(NSString*)viewController{
    self.sidePanelController.navigationItem.title = viewController;
    
    UIBarButtonItem *flipButton = [[UIBarButtonItem alloc]initWithImage:nil style:UIBarButtonItemStylePlain target:self action:@selector(showLeftPanelAnimated:)];
    flipButton = [self.sidePanelController leftButtonForCenterPanel];
    self.sidePanelController.navigationItem.leftBarButtonItem = flipButton;
    
    
    [self.sidePanelController setCenterPanel:[self.storyboard instantiateViewControllerWithIdentifier:viewController]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)colorMenuIcon:(id)sender isSelected:(MenuItemState)state{
    UIControl *control = (UIControl*)sender;
    UILabel *label = [control.subviews objectAtIndex:0];
    
    switch (state) {
            
        case MenuItemNormal:
            label.textColor = [UIColor whiteColor];
            control.backgroundColor = [UIColor clearColor];
            break;
        case MenuItemHighlighted:
            label.textColor = [UIColor whiteColor];
            control.backgroundColor = [UIColor lightGrayColor];
            break;
        case MenuItemSelected:
            label.textColor = [UIColor whiteColor];
            control.backgroundColor = [UIColor lightGrayColor];
            break;
        default:
            break;
    }
    /*NSString *lblString;
    for (UILabel*lbl in control.subviews) {
        if ([lbl isKindOfClass:[UILabel class]]) {
            lbl.textColor = menuColor;
            lblString = lbl.text;
        }
        
    }
    
    if ([lblString isEqualToString:@"Convert"]) {
        newImage = [UIImage convertIcon:menuColor];
    }
    else if ([lblString isEqualToString:@"Density"]){
        newImage = [UIImage densityIcon:menuColor];
    }
    else if ([lblString isEqualToString:@"Vessels"]){
        newImage = [UIImage vesselsIcon:menuColor];
    }
    else if ([lblString isEqualToString:@"Info"]){
        newImage = [UIImage infoIcon:menuColor];
    }
    imageViewFromControl.image = newImage;*/
    
    
}

@end
