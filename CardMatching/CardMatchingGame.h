//
//  CardMatchingGame.h
//  CardMatching
//
//  Created by Stuart Nelson on 10/30/15.
//  Copyright © 2015 Stuart Nelson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;

- (NSString *)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

- (void)twoCardMode;
- (void)threeCardMode;

@property (nonatomic, readonly) NSInteger score;

@end
