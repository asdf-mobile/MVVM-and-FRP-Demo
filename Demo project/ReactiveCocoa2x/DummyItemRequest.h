//
//  DummyItemRequest.h
//  ReactiveCocoa2x
//
//  Created by Szymon Kuczur on 20.03.2016.
//  Copyright © 2016 asdf mobile. All rights reserved.
//

@import Foundation;

#import <ReactiveCocoa/ReactiveCocoa.h>

@interface DummyItemRequest : NSObject

@property(nonatomic, strong, readonly) RACCommand *requestCommand;

@end
