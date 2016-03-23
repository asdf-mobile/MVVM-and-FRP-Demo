//
//  CollectionViewModel.h
//  ReactiveCocoa2x
//
//  Created by Szymon Kuczur on 20.03.2016.
//  Copyright © 2016 asdf mobile. All rights reserved.
//

@import Foundation;

#import "ItemViewModel.h"

@interface CollectionViewModel : NSObject

@property (copy, nonatomic, readonly) NSArray<ItemViewModel*> *items;

- (void)loadPage;

@end
