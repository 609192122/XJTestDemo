//
//  BFCell1TableViewCell.m
//  Example
//
//  Created by wans on 2017/5/8.
//  Copyright © 2017年 wans. All rights reserved.
//

#import "BFCell1TableViewCell.h"
#import "BFModel.h"
#import "UIResponder+BFEventManager.h"

@interface BFCell1TableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end
@implementation BFCell1TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)em_displayWithModel:(BFEventManagerBlock)eventBlock {

    BFEventModel *theModel = self.em_model(eventBlock);

    BFModel *model = theModel.model;
    self.textLabel.text = model.title;
//    self.label.text = model.title;
//    self.label.text = model.em_property(@"title");
}

@end
