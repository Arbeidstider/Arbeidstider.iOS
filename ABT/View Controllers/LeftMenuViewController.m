//
//  LeftMenuViewController.m
//  Arbeidstider
//
//  Created by Oscar Apeland on 09.09.13.
//  Copyright (c) 2013 Osc. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "SidePanelViewController.h"
#import "SingleTon.h"
@interface LeftMenuViewController ()
{
    
}
@property (strong) IBOutlet UITableView *menuTableView;
@property (retain) NSArray *viewsArray;
@property (retain) NSArray *imagesArray;
@end

@implementation LeftMenuViewController
-(BOOL)prefersStatusBarHidden{
    return YES;
}
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
    self.menuTableView.alwaysBounceVertical = NO;
    _viewsArray = [[NSArray alloc]initWithObjects:@"Forside",@"Dine Vakter",@"Oppslag",@"Personer",@"Penger",@"Innstillinger", nil];
    _imagesArray = [[NSArray alloc]initWithObjects:@"frontpage.png",@"vakter.png",@"oppslag.png",@"personer",@"penger.png",@"innstillinger.png",nil];
    self.menuTableView.backgroundColor = [UIColor colorWithRed:244.0/255 green:244.0/255 blue:244.0/255 alpha:1.0];
    self.menuTableView.frame = CGRectMake(0, HEADER_HEIGHT, self.view.frame.size.width, self.view.frame.size.height);
    
    /* KODE FOR Å LAGE FOOTER TIL SLIDEOUTMENU; UTILIZE LATER;
    UIControl *bottomView = [[UIControl alloc]initWithFrame:CGRectMake(0,self.view.frame.size.height-48, self.view.frame.size.width, 48)];
    [bottomView addTarget:self action:@selector(footerPressed) forControlEvents:UIControlEventTouchUpInside];
    bottomView.backgroundColor = [UIColor headerColor];
    [self.view addSubview:bottomView];
    */

}
-(void)footerPressed{
    NSLog(@"footer pressed");
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table View Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _viewsArray.count;    //count number of row from counting array hear cataGorry is An Array
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:MyIdentifier];
        cell.textLabel.text = [_viewsArray objectAtIndex:indexPath.row];
        cell.textLabel.font = [UIFont fontWithName:THIN size:16.0f];
        cell.imageView.bounds = CGRectMake(0, 0, 15, 15);
        cell.imageView.image = [UIImage imageNamed:[_imagesArray objectAtIndex:indexPath.row]];
        cell.imageView.backgroundColor = [UIColor colorWithRed:244.0/255 green:244.0/255 blue:244.0/255 alpha:1.0];
        
        cell.backgroundColor = [UIColor colorWithRed:244.0/255 green:244.0/255 blue:244.0/255 alpha:1.0];

        UIView *colorView = [[UIView alloc]init];
        colorView.backgroundColor = [UIColor colorWithRed:254.0/255 green:254.0/255 blue:254.0/255 alpha:1.0];
        colorView.layer.masksToBounds = YES;
        cell.selectedBackgroundView = colorView;
        
    }
    if (indexPath.row > _viewsArray.count) {
        return nil;
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 50;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [[SingleTon Views].SideView changeCenterPanel:[_viewsArray objectAtIndex:indexPath.row]];
    
    
}

@end
