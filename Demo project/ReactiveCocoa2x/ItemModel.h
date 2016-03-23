//
//  ItemModel.h
//  ReactiveCocoa2x
//
//  Created by Szymon Kuczur on 20.03.2016.
//  Copyright © 2016 asdf mobile. All rights reserved.
//

@import Foundation;

@interface ItemModel : NSObject

@property (copy, nonatomic, readonly) NSString *imageName;
@property (strong, nonatomic, readonly) NSNumber *counter;

- (instancetype)initWithImageName:(NSString*)imageName counter:(NSNumber*)counter;

- (void)increaseCounter;

@end
