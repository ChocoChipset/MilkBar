//
//  MBViewController.m
//  Example
//
//  Created by Hector Zarate on 5/3/13.
//  Copyright (c) 2013 Hector Zarate. All rights reserved.
//

#import "MBViewController.h"
#import "MBBarGrapher.h"

@interface MBViewController ()

@end

@implementation MBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *exampleValues = @[@23, @35.5, @20, @70.2, @45.5, @47.7, @13.2, @33.3, @69.999, @83.25, @90.2, @99.9];
    
    MBBarGrapher *barGrapher = [[MBBarGrapher alloc] initWithValues:exampleValues];
    
    CGFloat orangeColorComponents[4] = { 1.0, 0.77, 0.29, 1.0 };

    barGrapher.fillColor = [UIColor colorWithRed:orangeColorComponents[0]
                                           green:orangeColorComponents[1]
                                            blue:orangeColorComponents[2]
                                           alpha:orangeColorComponents[3]];
    self.graph.image = [barGrapher generateImageForSize:self.graph.frame.size];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
