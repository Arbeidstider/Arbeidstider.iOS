//
//  ABTMenuCell.m
//  Arbeidstider
//
//  Created by Oscar Apeland on 15.10.13.
//  Copyright (c) 2013 Oscar Apeland. All rights reserved.
//

#import "ABTMenuCell.h"

@implementation ABTMenuCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    if (selected) {
        UIView *view = [[UIView alloc]initWithFrame:self.frame];
        view.backgroundColor = [UIColor whiteColor];
        self.selectedBackgroundView = view;
    }
    // Configure the view for the selected state
}

@end
