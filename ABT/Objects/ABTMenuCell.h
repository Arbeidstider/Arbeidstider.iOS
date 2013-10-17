//
//  ABTMenuCell.h
//  Arbeidstider
//
//  Created by Oscar Apeland on 15.10.13.
//  Copyright (c) 2013 Oscar Apeland. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ABTMenuCell : UITableViewCell
@property (weak,nonatomic) IBOutlet UIImageView *menuIconImage;
@property (weak,nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak,nonatomic) IBOutlet UILabel *menuLabel;
@end
