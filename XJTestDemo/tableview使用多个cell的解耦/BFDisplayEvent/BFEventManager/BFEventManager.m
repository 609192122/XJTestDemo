//
//  BFEventManager.m
//  HomePage https://github.com/wans3112/BFDisplayEvent
//
//  Created by wans on 2017/4/10.
//  Copyright © 2017年 wans,www.wans3112.cn All rights reserved.
//

#import "BFEventManager.h"
#import "UIResponder+BFEventManager.h"

@interface BFEventManager ()

@property (nonatomic, weak, readwrite) UIResponder                          *em_target;

@end

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"
#pragma clang diagnostic ignored "-Wprotocol"

@implementation BFEventManager
#pragma clang diagnostic pop

- (void)didSelectItemWithModel:(BFEventModel *)eventModel {}

- (void)didSelectItemWithModelBlock:(BFEventManagerBlock)eventBlock {}

- (instancetype)initWithTarget:(id)target {

    self = [super init];
    if ( self ) {
        self.em_target = target;
    }
    return self;
}

- (void)em_didSelectItemWithEventType:(NSInteger)eventType {

    [self em_didSelectItemWithModelBlock:^(BFEventModel *eventModel) {
        eventModel.eventType = eventType;
    }];
    
}

- (void)em_didSelectItemWithIdentifier:(NSString *)identifier {
   
    [self em_didSelectItemWithModelBlock:^(BFEventModel *eventModel) {
        eventModel.identifier = identifier;
    }];
}

- (void)em_didSelectItemWithModel:(BFEventModel *)eventModel{
    if (self.em_eventBlock) {
        self.em_eventBlock(eventModel);
    }
}

//- (void)em_didSelectItemWithModelBlock:(BFEventManagerBlock)eventBlock{
//    if (self.em_model) {
//        self.em_model(eventBlock);
//    }
//}

#pragma mark - Getter&&Setter

- (BFEventModelBlock)em_model {
    
    return self.em_target.em_model;
}

- (UIViewController *)em_viewController {
    
    return self.em_target.em_viewController;
}

- (void)setEm_targetValueForKey:(BFSetValueForKeyBlock)em_ValueForKey {}

- (BFSetValueForKeyBlock)em_targetValueForKey {
    return self.em_target.em_valueForKey;
}

- (void)setEm_targetParamForKey:(BFSetValueForKeyBlock)em_targetParamForKey {}

- (BFSetValueForKeyBlock)em_targetParamForKey {
    return self.em_target.em_paramForKey;
}

@end
