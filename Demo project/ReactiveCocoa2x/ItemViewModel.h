//
//  ItemViewModel.h
//  ReactiveCocoa2x
//
//  Created by Szymon Kuczur on 20.03.2016.
//  Copyright © 2016 asdf mobile. All rights reserved.
//

@import Foundation;

#import <ReactiveCocoa/ReactiveCocoa.h>

@class ItemModel;

@interface ItemViewModel : NSObject

@property (strong, nonatomic, readonly) NSString *title;
@property (strong, nonatomic, readonly) NSString *imageName;

@property (strong, nonatomic, readonly) RACCommand *increaseCommand;

- (instancetype)initWithModel:(ItemModel*)model;

@end
