//
//  ViewController.m
//  HW MVC
//
//  Created by Daniil Novoselov on 08.11.14.
//  Copyright (c) 2014 Daniil Novoselov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UISwitch *switch1;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UIButton *colorButton;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"text"];
    if (str)
        self.textField.text = str;
    
    NSNumber *check = [[NSUserDefaults standardUserDefaults] objectForKey:@"switch"];
    check = check ? check : @0;
    [self.switch1 setOn:check.boolValue animated:NO];
    
    NSNumber *select = [[NSUserDefaults standardUserDefaults] objectForKey:@"select"];
    select = select ? select : @0;
    self.segment.selectedSegmentIndex = select.integerValue;
    
    NSNumber *sliderValue = [[NSUserDefaults standardUserDefaults] objectForKey:@"slider"];
    sliderValue = sliderValue ? sliderValue : @10;
    self.slider.value = sliderValue.floatValue;
    
    NSData *color = [[NSUserDefaults standardUserDefaults] objectForKey:@"color"];
    if (color)
        [self.colorButton setTintColor:[NSKeyedUnarchiver unarchiveObjectWithData:color]];
}

- (IBAction)textFieldEdited:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject:self.textField.text forKey:@"text"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (IBAction)switchEdited:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject:[[NSNumber alloc] initWithBool:self.switch1.isOn] forKey:@"switch"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (IBAction)segmentEdited:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject:[[NSNumber alloc] initWithInteger:self.segment.selectedSegmentIndex] forKey:@"select"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (IBAction)sliderEdited:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject:[[NSNumber alloc] initWithFloat:self.slider.value] forKey:@"slider"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (IBAction)colorButtonPressed:(id)sender {
    UIColor *color = [self randColor];
    [self.colorButton setTintColor:color];
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:color] forKey:@"color"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (IBAction)resetButtonPressed:(id)sender {
    
    self.textField.text = nil;
    [self.switch1 setOn:FALSE animated:YES];
    self.segment.selectedSegmentIndex = 0;
    self.slider.value = 10;
    self.colorButton.tintColor = self.resetButton.tintColor;
    
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"text"];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"switch"];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"select"];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"slider"];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"color"];
    
}

- (UIColor *)randColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    return color;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
