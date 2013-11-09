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
    NSArray *oppslagsArray;
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
    //Content table view
    oppslagTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, HEADER_HEIGHT, self.view.frame.size.width, self.view.frame.size.height-HEADER_HEIGHT) style:UITableViewStylePlain];
    oppslagTableView.delegate = self;
    oppslagTableView.dataSource = self;
    oppslagTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    oppslagTableView.separatorColor = [UIColor clearColor];
    //oppslagTableView.bounces = NO;
    [oppslagTableView registerNib:[UINib nibWithNibName:@"OppslagContentCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"OppslagContentCell"];
    [self.view addSubview:oppslagTableView];

    
    NSString* pathToFile = [[NSBundle mainBundle] pathForResource:@"oppslag" ofType: @"json"];
    NSString *file = [[NSString alloc] initWithContentsOfFile:pathToFile encoding:NSUTF8StringEncoding error:NULL];
    NSData *jsonData = [file dataUsingEncoding:NSUTF8StringEncoding];
    NSError *e;
    NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&e];
    
    oppslagsArray = array;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table View Delegate and DataSource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary * currentPost = [oppslagsArray objectAtIndex:indexPath.row];
    NSString * textString = [currentPost objectForKey:@"Content"];
    CGSize textSize = [textString sizeWithFont:[UIFont fontWithName:THIN size:17.0f] constrainedToSize:CGSizeMake(240, 20000) lineBreakMode: NSLineBreakByCharWrapping];
    float actualSize = textSize.height + 50;
    if (actualSize < 150) {
        return 150.0f;
    }
    else {
        return actualSize;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return oppslagsArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"OppslagContentCell";
    
    OppslagContentCell* cell = (OppslagContentCell*)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {

    }
    
    NSDictionary * currentPost = [oppslagsArray objectAtIndex:indexPath.row];
    cell.nameLabel.text = [currentPost objectForKey:@"Name"];
    [cell.nameLabel sizeToFit];
    cell.contentText.text = [currentPost objectForKey:@"Content"];
    [cell.contentText sizeToFit];
    cell.timeStamp.text = [currentPost objectForKey:@"Time"];
    [cell.timeStamp sizeToFit];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


-(void)makeTopBar{
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,HEADER_HEIGHT)];
    headerView.backgroundColor = [UIColor colorWithRed:43.0/255 green:45.0/255 blue:48.0/255 alpha:1];
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"Oppslag";
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
