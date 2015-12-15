//
//  Network.h
//  EasyTopup
//
//  Created by Eeposit1 on 12/14/15.
//  Copyright © 2015 Eeposit1. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface Network : NSObject
@property (nonatomic) NSString *networkID;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *prefix;
@property (nonatomic) NSString *suffix;
@property (nonatomic) CGFloat   order;
@property (nonatomic) BOOL      isSelected;

+ (NSMutableArray *)getListOfNetworks;
+ (Network *)findNetworkWithID:(NSString *)networkID;
@end
