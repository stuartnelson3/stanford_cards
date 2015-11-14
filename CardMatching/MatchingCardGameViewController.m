//
//  ViewController.m
//  CardMatching
//
//  Created by Stuart Nelson on 8/3/15.
//  Copyright (c) 2015 Stuart Nelson. All rights reserved.
//

#import "MatchingCardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface MatchingCardGameViewController ()
@property (strong, nonatomic) Deck *deck;
@property (nonatomic, strong) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
- (IBAction)resetGame:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
- (IBAction)switchGameMode:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameMode;
@end

typedef NS_ENUM(NSUInteger, SelectedSegmentIndex) {
    SelectedSegmentIndexTwoCard = 0,
    SelectedSegmentIndexThreeCard = 1,
};

@implementation MatchingCardGameViewController

- (CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                          usingDeck:[self createDeck]];
    
    return _game;
}

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (void)viewDidLoad {
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    if (self.gameMode.userInteractionEnabled) {
        self.gameMode.userInteractionEnabled = NO;
        self.gameMode.tintColor = [UIColor grayColor];
    }
    
    int cardIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];
}


- (IBAction)resetGame:(id)sender
{
    _game = nil;
    [self updateUI];
    self.gameMode.userInteractionEnabled = YES;
    self.gameMode.tintColor = [UIColor whiteColor];
}

- (void)updateUI
{
    for (UIButton *button in self.cardButtons) {
        int cardIndex = (int)[self.cardButtons indexOfObject:button];
        Card *card = [self.game cardAtIndex:cardIndex];
        [button setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [button setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        button.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed: card.isChosen ? @"front" : @"back"];
}

- (IBAction)switchGameMode:(id)sender
{
    switch (self.gameMode.selectedSegmentIndex) {
        case SelectedSegmentIndexTwoCard:
            [self.game twoCardMode];
            break;
        case SelectedSegmentIndexThreeCard:
            [self.game threeCardMode];
            break;
    }
}
@end
