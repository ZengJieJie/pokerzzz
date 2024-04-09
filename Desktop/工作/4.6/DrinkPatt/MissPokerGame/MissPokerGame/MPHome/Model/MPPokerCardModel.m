//
//  MPPokerCardModel.m
//  MissPokerGame
//
//  Created by mac on 2024/4/2.
//

#import "MPPokerCardModel.h"

@implementation MPPokerCardModel
- (instancetype)initWithNumber:(NSString*)number name:(NSString *)name flowerColor:(NSString *)flowerColor rule:(NSString *)rule{
    self = [super init];
    if (self) {
        self.cardName = name;
        self.cardNumber = number;
        self.cardFlowerColor = flowerColor;
        self.cardRule = rule;
    }
    return self;
}
+(NSArray<MPPokerCardModel*> *)defaultCardList {
//    NSArray *cardRuleList = @[@{@"cardName":@"指定牌",@"cardRule":@"拿到这张牌，可以指定一个人喝一杯"},
//                                 @{@"cardName":@"小姐牌",@"cardRule":@"拿到这张牌，即为小姐，先喝一杯喊出口号:大爷们吃好喝好,随后任何人喝酒都可以喊小姐陪酒,直到下一张2的出现 替换"},
//                                 @{@"cardName":@"逛三园",@"cardRule":@"'植物园、动物园、水果园里有什么’任选一个,每个人轮流说出一个种类，说不上来的喝酒"},
//                                 @{@"cardName":@"摸鼻子",@"cardRule":@"随时可以开始，默默将手放在鼻子上，最后一个将手放在鼻子上的人喝酒"},
//                                 @{@"cardName":@"照相机",@"cardRule":@"随时喊出“照相机”之后，除了喊出“照相机”的可以动以外，其他人都要保持不动"},
//                                 @{@"cardName":@"扭柳树",@"cardRule":@"从任意数字开始，例如：一棵柳树扭一扭,两棵柳树扭两扭,一直持续下去，直到有人口齿不清"},
//                                 @{@"cardName":@"逢7必过",@"cardRule":@"从任意数字开始，凡是带7或者7的倍数的数字，都要拍手示意跳过"},
//                                 @{@"cardName":@"厕所牌",@"cardRule":@"使用厕所牌以外，不能上厕所"},
//                                 @{@"cardName":@"自罚一杯",@"cardRule":@"抽到这张牌就为自己的莽撞自罚一杯吧~"},
//                                 @{@"cardName":@"神经病",@"cardRule":@"抽到这张牌后，大喊：“我是神经病， 随后只要和你说话的人，就要喝酒"},
//                                 @{@"cardName":@"左边喝",@"cardRule":@"左边的朋友喝"},
//                                 @{@"cardName":@"右边喝",@"cardRule":@"右边的朋友喝"},
//                                 @{@"cardName":@"倒酒牌",@"cardRule":@"杯中随意倒酒，下一个抽中倒酒牌的人，喝这杯酒"}];
    
    NSArray *cardRuleList = @[@{@"cardName":@"Specify the card",@"cardRule":@"When you get this card, you can designate one person to drink a drink"},
                                      @{@"cardName":@"Drinking Card",@"cardRule":@"When you get this card, it is a drink, and then anyone who drinks can call a drink until the next 2 appears and replaces it."},
                                      @{@"cardName":@"Visiting the Three Gardens",@"cardRule":@"What's in the botanical garden, the zoo, the fruit garden?' Pick one, and each person takes turns naming a kind of, indefinable drink."},
                                      @{@"cardName":@"touch nose",@"cardRule":@"You can start at any time, silently put your hand on your nose, and the last person to put your hand on your nose drinks"},
                                      @{@"cardName":@"Camera",@"cardRule":@"After shouting ‘Camera’ at any time, except for the one who shouted ‘Camera’ can move, everyone else must remain still"},
                                      @{@"cardName":@"twisted willow tree",@"cardRule":@"Start from any number, for example: a willow tree twists once, two willow trees twist twice, and continues until someone is slurred. "},
                                      @{@"cardName":@"Every 7 must be passed",@"cardRule":@"Start from any number, and any number with 7 or a multiple of 7 must be clapped to indicate skipping"},
                                      @{@"cardName":@"Toilet sign",@"cardRule":@"You cannot go to the toilet except by using the toilet sign"},
                                      @{@"cardName":@"Punish yourself with a drink",@"cardRule":@"If you draw this card, you will punish yourself with a drink for your recklessness~"},
                                      @{@"cardName":@"Crazy",@"cardRule":@"After drawing this card, shout: ‘I am crazy, and anyone who talks to you from now on will drink"},
                                      @{@"cardName":@"Drink on the left",@"cardRule":@"Friend on the left drinks"},
                                      @{@"cardName":@"Drink on the right",@"cardRule":@"Friend on the right drinks"},
                              @{@"cardName":@"Pour the wine card",@"cardRule":@"Pour wine into the cup at will. The next person who draws the wine pouring card will drink this glass of wine"}];
//    NSArray *cardNumberList = @[@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
//    NSArray *cardFlowerColorList = @[@"♠️",@"♥️",@"♣️",@"♦️"];
    NSArray *cardNumberList = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13"];
    NSArray *cardFlowerColorList = @[@"A",@"B",@"c",@"d"];
    NSMutableArray *cardList = @[].mutableCopy;
    
    for (int i = 0; i<cardRuleList.count; i++) {
        NSDictionary *cardDic = cardRuleList[i];
        NSString *number = cardNumberList[i];
        NSString *cardName = cardDic[@"cardName"];
        NSString *cardRule = cardDic[@"cardRule"];
        for (int j = 0; j<cardFlowerColorList.count; j++) {
            NSString *flowerColor = cardFlowerColorList[j];
            [cardList addObject:[[MPPokerCardModel alloc] initWithNumber:number  name:cardName flowerColor:flowerColor rule:cardRule]];
        }
    }
    return cardList;
}
+ (NSMutableArray *)sortedRandomArrayByArray:(NSMutableArray *)array{
    
    NSMutableArray *randomArray = [[NSMutableArray alloc]init];
    while (randomArray.count != array.count) {
        int x = arc4random() % array.count;
        id obj = array[x];
        if(![randomArray containsObject:obj]){
            [randomArray addObject:obj];
        }
    }
    
    return randomArray;
}
@end
