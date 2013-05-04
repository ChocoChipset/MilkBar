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
    
    NSArray *exampleValues = @[@23, @35.5, @20, @70.2, @45.5, @99.9];
    
    MBBarGrapher *barGrapher = [[MBBarGrapher alloc] initWithValues:exampleValues];
    
    // TODO: this size should correspond to self.graph.frame
    CGSize testSize = { 300.0, 200.0 };
    
    self.graph.image = [barGrapher generateImageForSize:testSize];
    
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
