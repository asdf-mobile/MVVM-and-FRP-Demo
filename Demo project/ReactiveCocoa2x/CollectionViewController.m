//
//  CollectionViewController.m
//  ReactiveCocoa2x
//
//  Created by Szymon Kuczur on 20.03.2016.
//  Copyright © 2016 asdf mobile. All rights reserved.
//

#import "CollectionViewController.h"

#import <ReactiveCocoa/ReactiveCocoa.h>

#import "CollectionViewModel.h"
#import "CollectionViewCell.h"

// /////////////////////////////////////////////////////////////////////////////

static NSString * const reuseIdentifier = @"ItemCell";

// /////////////////////////////////////////////////////////////////////////////

@interface CollectionViewController ()

@property (strong, nonatomic) CollectionViewModel *colelctionViewModel;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *busy;

@end

// /////////////////////////////////////////////////////////////////////////////

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Ideally passed through constructor
    self.colelctionViewModel = [[CollectionViewModel alloc] init];
    [self bindViewModel];
    
    // Could be a Command
    [self.colelctionViewModel loadPage];
}

- (void)bindViewModel {
    @weakify(self);
    [[RACObserve(self.colelctionViewModel, items) skip:1] subscribeNext:^(id x) {
        @strongify(self);
        [self.collectionView reloadData];
    }];
    
    RAC(self.busy, hidden) = [RACObserve(self.colelctionViewModel, items) map:^NSNumber *(NSArray *items) {
        return @(items.count != 0);
    }];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.colelctionViewModel.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    ItemViewModel *viewModel = self.colelctionViewModel.items[indexPath.row];
    [cell configureForViewModel:viewModel];
    
    return cell;
}

@end
