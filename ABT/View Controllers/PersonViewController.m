//
//  PersonViewController.m
//  Arbeidstider
//
//  Created by Oscar Apeland on 09.09.13.
//  Copyright (c) 2013 Osc. All rights reserved.
//

#import "PersonViewController.h"
#import "ABTPerson.h"
#import "ProfileViewController.h"
#import "UIViewController+MJPopupViewController.h"
#import "MJDetailViewController.h"
@interface PersonViewController () <UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *tier1array;
    NSMutableArray *tier2array;
    NSMutableArray *tier0array;
}
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
    [SingleTon Shifts].PersonView = self;
    tier2array = [[NSMutableArray alloc]init];
    tier1array = [[NSMutableArray alloc]init];
    tier0array = [[NSMutableArray alloc]init];

    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,HEADER_HEIGHT,self.view.bounds.size.width, self.view.bounds.size.height-HEADER_HEIGHT) style:UITableViewStyleGrouped];
    
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.bounces = NO;
    
    [self.view addSubview:tableView];
    
    
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
    
    for (ABTPerson *person in [SingleTon Shifts].allPersons) {
        if ([person.workerClass isEqualToString:@"0"]) {
            [tier0array addObject:person];
        }
        else if ([person.workerClass isEqualToString:@"1"]){
            [tier1array addObject:person];
        }
        else if ([person.workerClass isEqualToString:@"2"]) {
            [tier2array addObject:person];
        }
    }
    
	// Do any additional setup after loading the view.
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return @"sjefer";
    }
    if (section == 1) {
        return @"negere";
    }
    else {
    return @"klasse";
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 ) {
        return tier0array.count;
    }
    if (section == 1) {
        return tier1array.count;
    }
    if (section == 2) {
        return tier2array.count;
    }
    else {
        return 0;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    //NSLog(@"Setupcell for indexpath:%lu %ld",(long)indexPath.section,(long)indexPath.row);
    // Configure the cell.
    cell.textLabel.text = @"testString";
    if (indexPath.section == 0) {
        ABTPerson *pers = [tier0array objectAtIndex:indexPath.row];
        cell.textLabel.text = pers.name;
    }
    else if (indexPath.section == 1){
        ABTPerson *pers = [tier1array objectAtIndex:indexPath.row];
        cell.textLabel.text = pers.name;
    }
    else if (indexPath.section == 2){
        ABTPerson *pers = [tier2array objectAtIndex:indexPath.row];
        cell.textLabel.text = pers.name;
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ABTPerson *person;
    
    int row = indexPath.row;
    int sect = indexPath.section;
    if (sect == 0) {
        person = [tier0array objectAtIndex:row];
    }
    else if (sect == 1){
        person = [tier1array objectAtIndex:row];
    }
    else if (sect == 2){
        person = [tier2array objectAtIndex:row];
    }
    [SingleTon Shifts].currentPerson = person;
    [self presentPopupViewController:[[ProfileViewController alloc]init] animationType:MJPopupViewAnimationSlideRightLeft];
    
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
-(void)dismissPopup{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideLeftRight];
    
}

@end
