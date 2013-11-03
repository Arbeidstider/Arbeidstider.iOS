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
    self.menuTableView.separatorColor = [UIColor grayColor];
    self.menuTableView.separatorInset = UIEdgeInsetsMake(1, 0, 0, 1);
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.menuTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition: UITableViewScrollPositionNone];

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
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _viewsArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"ABTMenuCell";
    
    ABTMenuCell *cell = (ABTMenuCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ABTMenuCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.menuLabel.text = [_viewsArray objectAtIndex:indexPath.row];
    cell.menuIconImage.image = [UIImage imageNamed:[_imagesArray objectAtIndex:indexPath.row]];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
[self.sidePanelController setCenterPanel:[self.storyboard instantiateViewControllerWithIdentifier:[_viewsArray objectAtIndex:indexPath.row]]];
}

@end
