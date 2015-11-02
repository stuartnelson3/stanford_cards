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
@end

@implementation CardMatchingGame

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS_TWO_CARD = 4;
static const int MATCH_BONUS_THREE_CARD = 6;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            if ([self isTwoCardMode]) {
                [self twoCardChoose:card];
            } else if ([self isThreeCardMode]) {
                [self threeCardChoose:card];
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}

- (void)threeCardChoose:(Card *)card
{
    Card *pcard;
    int pmatch = 0;
    for (Card *otherCard in self.cards) {
        if (otherCard.isChosen && !otherCard.isMatched) {
            if (pcard == nil) {
                pcard = otherCard;
                pmatch = [card match:@[pcard]];
                continue;
            }
            
            int matchScore = [card match:@[otherCard]];
            if (matchScore || pmatch) {
                if (pcard != nil) {
                    self.score += (matchScore + pmatch) * MATCH_BONUS_THREE_CARD;
                    card.matched = YES;
                    otherCard.matched = YES;
                    pcard.matched = YES;
                }
            } else {
                self.score -= MISMATCH_PENALTY;
                otherCard.chosen = NO;
                pcard.chosen = NO;
            }
        }
    }
}

- (void)twoCardChoose:(Card *)card
{
    for (Card *otherCard in self.cards) {
        if (otherCard.isChosen && !otherCard.isMatched) {
            int matchScore = [card match:@[otherCard]];
            if (matchScore) {
                self.score += matchScore * MATCH_BONUS_TWO_CARD;
                card.matched = YES;
                otherCard.matched = YES;
            } else {
                self.score -= MISMATCH_PENALTY;
                otherCard.chosen = NO;
            }
            break;
        }
    }
}

- (void)twoCardMode
{
    _mode = @"twoCardMode";
}

- (BOOL)isTwoCardMode
{
    return [_mode isEqual: @"twoCardMode"];
}

- (void)threeCardMode
{
    _mode = @"threeCardMode";
}

- (BOOL)isThreeCardMode
{
    return [_mode isEqual: @"threeCardMode"];
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
    
    [self twoCardMode];
    
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
