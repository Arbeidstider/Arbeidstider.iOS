//
//  OppslagContentCell.h
//  Arbeidstider
//
//  Created by Oscar Apeland on 30.10.13.
//  Copyright (c) 2013 Oscar Apeland. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OppslagContentCell : UITableViewCell

@property (weak,nonatomic) IBOutlet UILabel *nameLabel;
@property (weak,nonatomic) IBOutlet UILabel *contentText;
@property (weak,nonatomic) IBOutlet UILabel *timeStamp;
@property (weak,nonatomic) IBOutlet UIImageView *profilePicture;

@end
