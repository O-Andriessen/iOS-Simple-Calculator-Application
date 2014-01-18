//
//  CustomColors.m
//  Calculator
//
//  Created by Olivier Andriessen on 18/01/14.
//  Copyright (c) 2014 Olivier Andriessen. All rights reserved.
//

#import "CustomColors.h"

@implementation UIColor (custom)
+(UIColor *)color: (NSString *) color{
    
    UIColor *customColor;
    
    if ([color isEqualToString:@"grey"]){
        customColor = [UIColor blackColor];
    } else if ([color isEqualToString:@"green"]){
        customColor = [UIColor colorWithRed:103/255.0 green:252/255.0 blue:112/255.0 alpha:1.0];
    } else if ([color isEqualToString:@"yellow"]){
        customColor = [UIColor colorWithRed:255/255.0 green:219/255.0 blue:76/255.0 alpha:1.0];
    } else if ([color isEqualToString:@"orange"]){
        customColor = [UIColor colorWithRed:255/255.0 green:149/255.0 blue:0/255.0 alpha:1.0];
    } else if ([color isEqualToString:@"red"]){
        customColor = [UIColor colorWithRed:255/255.0 green:94/255.0 blue:58/255.0 alpha:1.0];
    } else if ([color isEqualToString:@"purple"]){
        customColor = [UIColor colorWithRed:198/255.0 green:68/255.0 blue:252/255.0 alpha:1.0];
    } else if ([color isEqualToString:@"blue"]){
        customColor = [UIColor colorWithRed:26/255.0 green:214/255.0 blue:253/255.0 alpha:1.0];
    } else if ([color isEqualToString:@"lightgrey"]){
        customColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:241/255.0 alpha:1.0];
    } else if ([color isEqualToString:@"lightgreen"]){
        customColor = [UIColor colorWithRed:231/255.0 green:254/255.0 blue:226/255.0 alpha:1.0];
    } else if ([color isEqualToString:@"lightyellow"]){
        customColor = [UIColor colorWithRed:255/255.0 green:248/255.0 blue:219/255.0 alpha:1.0];
    } else if ([color isEqualToString:@"lightorange"]){
        customColor = [UIColor colorWithRed:255/255.0 green:234/255.0 blue:204/255.0 alpha:1.0];
    } else if ([color isEqualToString:@"lightred"]){
        customColor = [UIColor colorWithRed:255/255.0 green:223/255.0 blue:216/255.0 alpha:1.0];
    } else if ([color isEqualToString:@"lightpurple"]){
        customColor = [UIColor colorWithRed:244/255.0 green:218/255.0 blue:254/255.0 alpha:1.0];
    } else if ([color isEqualToString:@"lightblue"]){
        customColor = [UIColor colorWithRed:209/255.0 green:247/255.0 blue:255/255.0 alpha:1.0];
    }
    
    return customColor;
}
@end
