//
//  DummyItemRequest.m
//  ReactiveCocoa2x
//
//  Created by Szymon Kuczur on 20.03.2016.
//  Copyright © 2016 asdf mobile. All rights reserved.
//

#import "DummyItemRequest.h"

#import "ItemModel.h"
#import "ItemViewModel.h"

// /////////////////////////////////////////////////////////////////////////////

@interface DummyItemRequest ()

@property(nonatomic, strong, readwrite) RACCommand *requestCommand;

@end

// /////////////////////////////////////////////////////////////////////////////

@implementation DummyItemRequest

- (instancetype)init {
    self = [super init];
    if (self) {
        @weakify(self);
        self.requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    sleep(1);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        @strongify(self);
                        [subscriber sendNext:[self itemViewModels]];
                        [subscriber sendCompleted];
                    });
                });
                
                // disposable (it can for instance cancel an operation)
                return nil;
            }];
        }];
    }
    return self;
}

#pragma mark - Hardcoded presentation data

- (NSArray<ItemViewModel*>*)itemViewModels {
    NSMutableArray *viewModels = [NSMutableArray array];
    NSArray *models = [self itemModels];
    
    for (ItemModel *model in models) {
        ItemViewModel *item = [[ItemViewModel alloc] initWithModel:model];
        [viewModels addObject:item];
    }
    
    return [viewModels copy];
}

- (NSArray<ItemModel*>*)itemModels {
    return @[
             [[ItemModel alloc] initWithImageName:@"image_1" counter:@(0)],
             [[ItemModel alloc] initWithImageName:@"image_2" counter:@(0)],
             [[ItemModel alloc] initWithImageName:@"image_3" counter:@(0)],
             [[ItemModel alloc] initWithImageName:@"image_4" counter:@(0)],
             [[ItemModel alloc] initWithImageName:@"image_5" counter:@(0)],
             [[ItemModel alloc] initWithImageName:@"image_6" counter:@(0)],
             [[ItemModel alloc] initWithImageName:@"image_7" counter:@(0)],
             [[ItemModel alloc] initWithImageName:@"image_8" counter:@(0)],
             [[ItemModel alloc] initWithImageName:@"image_9" counter:@(0)],
             ];
}

@end
