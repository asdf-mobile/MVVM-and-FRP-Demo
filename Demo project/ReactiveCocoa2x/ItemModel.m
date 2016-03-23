//
//  ItemModel.m
//  ReactiveCocoa2x
//
//  Created by Szymon Kuczur on 20.03.2016.
//  Copyright © 2016 asdf mobile. All rights reserved.
//

#import "ItemModel.h"

// /////////////////////////////////////////////////////////////////////////////

@interface ItemModel ()

@property (copy, nonatomic, readwrite) NSString *imageName;
@property (strong, nonatomic, readwrite) NSNumber *counter;

@end

// /////////////////////////////////////////////////////////////////////////////

@implementation ItemModel

- (instancetype)initWithImageName:(NSString*)imageName counter:(NSNumber*)counter {
    self = [self init];
    if (self) {
        self.imageName = imageName;
        self.counter = counter;
    }
    return self;
}

#pragma mark - Counter

- (void)increaseCounter {
    self.counter = @([self.counter integerValue] + 1);
}


@end
