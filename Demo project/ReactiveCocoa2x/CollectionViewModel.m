//
//  CollectionViewModel.m
//  ReactiveCocoa2x
//
//  Created by Szymon Kuczur on 20.03.2016.
//  Copyright © 2016 asdf mobile. All rights reserved.
//

#import "CollectionViewModel.h"

#import "DummyItemRequest.h"

// /////////////////////////////////////////////////////////////////////////////

@interface CollectionViewModel ()

@property (copy, nonatomic, readwrite) NSArray<ItemViewModel*> *items;
@property (strong, nonatomic) DummyItemRequest *request;

@end

// /////////////////////////////////////////////////////////////////////////////

@implementation CollectionViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.items = @[];
        self.request = [[DummyItemRequest alloc] init];
        [self bindRequest];
    }
    return self;
}

- (void)bindRequest {
    @weakify(self);
    [[self.request.requestCommand.executionSignals switchToLatest] subscribeNext:^(NSArray *viewModels) {
        @strongify(self);
        self.items = [self.items arrayByAddingObjectsFromArray:viewModels];
    }];
}

#pragma mark - Loading Page

- (void)loadPage {
    [self.request.requestCommand execute:nil];
}

@end
