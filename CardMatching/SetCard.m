//
//  SetCard.m
//  CardMatching
//
//  Created by Stuart Nelson on 11/14/15.
//  Copyright © 2015 Stuart Nelson. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard
+ (NSArray *)validRanks {
    return @[@"1", @"2", @"3"];
}

+ (NSArray *)validShading {
    return @[@"solid", @"striped", @"open"];
};

+ (NSArray *)validSymbols {
    return @[@"◼︎", @"▲", @"●"];
}

+ (NSArray *)validColor {
    return @[@"purple", @"red", @"green"];
};

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    // a match means they all share a single attribute:
    // either rank, symbol, shading, or color
    if ([otherCards count] == 2) {
        __block BOOL notSetCard = NO;
        
        [otherCards enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if (![obj isKindOfClass:[SetCard class]]) {
                notSetCard = TRUE;
                *stop = YES;
            }
        }];
        
        if (notSetCard) return score;
        
        NSArray *attrs = @[@"rank", @"symbol", @"shading", @"color"];
        for (int i = 0; i < [attrs count]; i++) {
            if ([self matchAttr:attrs[i] cards:otherCards]) {
                return 4;
            }
        }
    }
    
    return score;
}

- (BOOL)matchAttr:(NSString *)attr cards:(NSArray *)otherCards
{
    BOOL match = NO;
    
    NSArray *ary = [otherCards arrayByAddingObjectsFromArray:@[self]];
    NSArray *attrAry = [ary valueForKey:attr];
    
    NSSet *uniqueItems = [NSSet setWithArray:attrAry];
    if ([uniqueItems count] == 1) {
        match = YES;
    }
    
    return match;
}

- (NSString *)contents {
    return [NSString stringWithFormat:@"%@%@", self.rank, self.symbol];
}
@end
