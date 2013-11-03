//
//  OppslagViewController.m
//  Arbeidstider
//
//  Created by Oscar Apeland on 10.09.13.
//  Copyright (c) 2013 Osc. All rights reserved.
//

#import "OppslagViewController.h"
#import "ABTData.h"
#import "OppslagContentCell.h"
@interface OppslagViewController () <UITableViewDelegate,UITableViewDataSource>
{
    UITableView *oppslagTableView;
    
}

@end

@implementation OppslagViewController

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table View Delegate and DataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arc4random()%50;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"OppslagContentCell";
    OppslagContentCell* cell = (OppslagContentCell*)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[OppslagContentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.frame = CGRectMake(0, 0, 100, 100);
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
    [self.sidePanelController showLeftPanelAnimated:YES];
}
@end
