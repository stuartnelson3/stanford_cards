//
//  SetDeck.m
//  CardMatching
//
//  Created by Stuart Nelson on 11/14/15.
//  Copyright © 2015 Stuart Nelson. All rights reserved.
//

#import "SetDeck.h"

@implementation SetDeck
- (instancetype)init
{
    return [self initWithColors:[SetCard validColor] withSymbols:[SetCard validSymbols]];
}

- (instancetype) initWithColors:(NSArray *)colors withSymbols:(NSArray *)symbols
{
    self = [super init];
    
    if (self) {
        for (NSString *rank in [SetCard validRanks]) {
            for (NSString *symbol in symbols) {
                for (NSString *shading in [SetCard validShading]) {
                    for (NSString *color in colors) {
                        SetCard *card = [[SetCard alloc] init];
                        card.rank = rank;
                        card.symbol = symbol;
                        card.shading = shading;
                        card.color = color;
                        [self addCard:card];
                    }
                }
            }
        }
    }
    
    return self;
}
@end
