//
//  CardMatchingGame.m
//  CardMatching
//
//  Created by Stuart Nelson on 10/30/15.
//  Copyright © 2015 Stuart Nelson. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards;
@property (nonatomic, strong) NSString *mode;
@property (nonatomic, strong) NSArray *modes;
@end

@implementation CardMatchingGame

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            // match against another card
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                        self.score += matchScore * MATCH_BONUS;
                        card.matched = YES;
                        otherCard.matched = YES;
                    } else {
                        self.score -= MISMATCH_PENALTY;
                        otherCard.chosen = NO;
                    }
                    break;
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}

- (void)setMode:(NSString *)mode
{
    if ([self.modes indexOfObject:mode] == NSNotFound) {
        _mode = [self.modes firstObject];
    }
    _mode = mode;
}

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    if (!self) return self;
    
    _modes = @[@"twoCard", @"threeCard"];
    
    for (int i = 0; i < count; i++) {
        Card *card = [deck drawRandomCard];
        if (!card) {
            self = nil;
            break;
        }
        
        self.cards[i] = card;
    }
    
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    if (index < self.cards.count) {
        return [self.cards objectAtIndex:index];
    }
    
    return nil;
}
@end
