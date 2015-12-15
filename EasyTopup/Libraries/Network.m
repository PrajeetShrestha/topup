//
//  Network.m
//  EasyTopup
//
//  Created by Eeposit1 on 12/14/15.
//  Copyright © 2015 Eeposit1. All rights reserved.
//

#import "Network.h"

@implementation Network

+ (NSMutableArray *)getListOfNetworks {
    NSMutableArray *_listOfNetworks = [NSMutableArray new];
    Network *ntcPostPaid = [Network new];
    ntcPostPaid.name = @"NTC Post Paid";
    ntcPostPaid.prefix = @"*411*";
    ntcPostPaid.suffix = @"*10#";
    ntcPostPaid.networkID = @"ntcpostpaid";
    ntcPostPaid.isSelected = NO;
    [_listOfNetworks addObject:ntcPostPaid];
    
    Network *ntcPrePaid = [Network new];
    ntcPrePaid.name = @"NTC Pre Paid";
    ntcPrePaid.prefix = @"*411*";
    ntcPrePaid.suffix = @"*10#";
    ntcPrePaid.networkID = @"ntcprepaid";
    ntcPrePaid.isSelected = NO;
    [_listOfNetworks addObject:ntcPrePaid];
    
    return _listOfNetworks;
}

+ (Network *)findNetworkWithID:(NSString *)networkID {
    NSMutableArray *array = [Network getListOfNetworks];
    for (Network *network in array) {
        if ([network.networkID isEqualToString:networkID]) {
            return network;
        }
    }
    return nil;
}

@end
