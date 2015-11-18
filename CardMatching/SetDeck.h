//
//  SetDeck.h
//  CardMatching
//
//  Created by Stuart Nelson on 11/14/15.
//  Copyright © 2015 Stuart Nelson. All rights reserved.
//

#import "Deck.h"
#import "SetCard.h"

@interface SetDeck : Deck
- (instancetype) initWithColors:(NSArray *)colors withSymbols:(NSArray *)symbols;
@end
