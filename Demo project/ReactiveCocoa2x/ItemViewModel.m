//
//  ItemViewModel.m
//  ReactiveCocoa2x
//
//  Created by Szymon Kuczur on 20.03.2016.
//  Copyright © 2016 asdf mobile. All rights reserved.
//

#import "ItemViewModel.h"

#import "ItemModel.h"

// /////////////////////////////////////////////////////////////////////////////

@interface ItemViewModel ()

@property (strong, nonatomic) ItemModel *model;

@property (strong, nonatomic, readwrite) RACCommand *increaseCommand;

@end

// /////////////////////////////////////////////////////////////////////////////

@implementation ItemViewModel

- (instancetype)initWithModel:(ItemModel*)model {
    self = [self init];
    if (self) {
        self.model = model;
        
        RACSignal *enabledSingal = [RACObserve(self.model, counter) map:^NSNumber *(NSNumber *counter) {
            return @([counter integerValue] < 10);
        }];
        @weakify(self);
        self.increaseCommand = [[RACCommand alloc] initWithEnabled: enabledSingal
                                                       signalBlock:^RACSignal *(id input) {
            @strongify(self);
            [self.model increaseCounter];
            return [RACSignal empty];
        }];
        
        [self bindModel];
    }
    return self;
}

#pragma mark - Initialize Binding 

- (void)bindModel {
    RAC(self, title) = [RACObserve(self.model, counter) map:^NSString *(NSNumber *value) {
        return [NSString stringWithFormat:@"times clicked: %@", value];
    }];
    
    RAC(self, imageName) = RACObserve(self.model, imageName);
}

@end
