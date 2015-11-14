//
//  SetCard.h
//  CardMatching
//
//  Created by Stuart Nelson on 11/14/15.
//  Copyright © 2015 Stuart Nelson. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card
+ (NSArray *)validRanks;
+ (NSArray *)validSymbols;
+ (NSArray *)validShading;
+ (NSArray *)validColor;

@property (strong, nonatomic) NSString *rank;
@property (strong, nonatomic) NSString *symbol;
@property (strong, nonatomic) NSString *shading;
@property (strong, nonatomic) NSString *color;
@end
