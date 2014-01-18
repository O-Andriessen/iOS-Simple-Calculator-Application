//
//  ViewController.h
//  Calculator
//
//  Created by Olivier Andriessen on 19/01/14.
//  Copyright (c) 2014 Olivier Andriessen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface ViewController : UIViewController

#pragma mark - Outlets for display

@property (nonatomic, strong) IBOutlet UILabel * displayLabel;
@property (nonatomic, strong) IBOutlet UIView * displayView;

#pragma mark - Outlets for keypad

@property (nonatomic, strong) IBOutletCollection(UIButton) NSArray * keypadButtons;

@property (nonatomic, strong) IBOutlet UIButton * eraseButton;
@property (nonatomic, strong) IBOutlet UIButton * percentButton;
@property (nonatomic, strong) IBOutlet UIButton * divideButton;
@property (nonatomic, strong) IBOutlet UIButton * multiplyButton;
@property (nonatomic, strong) IBOutlet UIButton * addButton;
@property (nonatomic, strong) IBOutlet UIButton * subtractButton;
@property (nonatomic, strong) IBOutlet UIButton * changeColorButton;

#pragma mark - Display methods

- (void)showEraseButton;
- (IBAction)beginErase;
- (void)eraseDigit;
- (IBAction)endErase;

#pragma mark - Display methods

- (IBAction)clickDigit: (UIButton *) sender;
- (IBAction)clickOperator: (UIButton *) sender;
- (IBAction)clickComma;
- (IBAction)clickPlusMinus;

- (IBAction)clickEquals;
- (IBAction)clearEverything;

#pragma mark - Process' primitives

@property double firstEnteredValue;
@property double secondEnteredValue;
@property double resultValue;

#pragma mark - Process methods

- (IBAction)deselectOpButtons;
- (void)processEnteredValue;
- (void)processSum;

#pragma mark - User Interface methods

- (IBAction)clickButton;
- (IBAction)setUserInterfaceColor;

@end
