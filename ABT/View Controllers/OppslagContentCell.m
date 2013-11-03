//
//  OppslagContentCell.m
//  Arbeidstider
//
//  Created by Oscar Apeland on 30.10.13.
//  Copyright (c) 2013 Oscar Apeland. All rights reserved.
//

#import "OppslagContentCell.h"

@implementation OppslagContentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.frame = CGRectMake(0, 0, 100, 200);
        
        UIView *testView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 200)];
        testView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:testView];

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
