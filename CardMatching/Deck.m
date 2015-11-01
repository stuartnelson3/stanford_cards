//
//  Deck.m
//  CardMatching
//
//  Created by Stuart Nelson on 8/3/15.
//  Copyright (c) 2015 Stuart Nelson. All rights reserved.
//

#import "Deck.h"

@interface Deck ()
@property (strong, nonatomic) NSMutableArray *cards;
@end

@implementation Deck

- (NSMutableArray *)cards {
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    
    return _cards;
}

- (void)addCard:(Card *)card atTop:(BOOL)atTop {
    if (atTop) {
        [self.cards insertObject:card atIndex:0];
        return;
    }
    
    [self.cards addObject:card];
}

- (void)addCard:(Card *)card {
    [self addCard:card atTop:NO];
}

- (Card *)drawRandomCard {
    Card *randomCard = nil;
    
    if ([self.cards count]) {
        unsigned i = arc4random() % [self.cards count];
        randomCard = self.cards[i];
        [self.cards removeObjectAtIndex:i];
    }
    
    return randomCard;
}
@end
