//
//  CollectionViewCell.h
//  ReactiveCocoa2x
//
//  Created by Szymon Kuczur on 20.03.2016.
//  Copyright © 2016 asdf mobile. All rights reserved.
//

@import UIKit;

@class ItemViewModel;

@interface CollectionViewCell : UICollectionViewCell

- (void)configureForViewModel:(ItemViewModel*)item;

@end
