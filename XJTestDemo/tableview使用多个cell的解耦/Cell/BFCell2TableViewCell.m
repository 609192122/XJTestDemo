//
//  BFCell2TableViewCell.m
//  Example
//
//  Created by wans on 2017/5/8.
//  Copyright © 2017年 wans. All rights reserved.
//

#import "BFCell2TableViewCell.h"
#import "BFModel.h"
#import "UIResponder+BFEventManager.h"

@interface BFCell2TableViewCell (){
    BFEventModel *_theModel;
}
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation BFCell2TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)buttonPressed:(id)sender {
    
}

- (void)em_displayWithModel:(BFEventManagerBlock)eventBlock {
    
    _theModel = self.em_model(eventBlock);
    
    BFModel *model = _theModel.model;
//    NSLog(@"model.title:%@", model.em_property(@"title"));
    NSLog(@"model.title:%@", [model title]);
    // 此处传入本为BFModel2，并无title字段，具体参考BFModel2查看
    [self.button setTitle:[model title] forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonClick{
    ///接管按钮事件
    [self.eventManager em_didSelectItemWithModel:_theModel];
}

@end
