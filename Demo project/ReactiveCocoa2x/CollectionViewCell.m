//
//  CollectionViewCell.m
//  ReactiveCocoa2x
//
//  Created by Szymon Kuczur on 20.03.2016.
//  Copyright © 2016 asdf mobile. All rights reserved.
//

#import "CollectionViewCell.h"

#import "ItemViewModel.h"

#import <ReactiveCocoa/ReactiveCocoa.h>

// /////////////////////////////////////////////////////////////////////////////

@interface CollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

// /////////////////////////////////////////////////////////////////////////////

@implementation CollectionViewCell

- (void)configureForViewModel:(ItemViewModel*)item {

    RACSignal *imageSingal =  [[[[RACObserve(item, imageName)
                                   deliverOn:[RACScheduler scheduler]]
                                  map:^UIImage *(NSString *imageName) {
                                      sleep(1);
                                      return [UIImage imageNamed:imageName];
                                  }] deliverOnMainThread]
                                takeUntil:self.rac_prepareForReuseSignal];
    
    RACSignal *emptyImageSignal = [[self.rac_prepareForReuseSignal map:^UIImage *(id value) {
        return nil;
    }] take:1];
    
    RAC(self.imageView,image) = [RACSignal merge:@[imageSingal, emptyImageSignal]];
    
    [self.button rac_liftSelector:@selector(setTitle:forState:)
                       withSignals:
     [RACObserve(item, title) takeUntil:self.rac_prepareForReuseSignal],
     [[RACSignal return:@(UIControlStateNormal)] takeUntil:self.rac_prepareForReuseSignal], nil];
    
    self.button.rac_command = item.increaseCommand;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.button.rac_command = nil;
}

@end
