//
//  ExampleTests.m
//  ExampleTests
//
//  Created by Hector Zarate on 5/3/13.
//  Copyright (c) 2013 Hector Zarate. All rights reserved.
//

#import "ExampleTests.h"
#import "MBBarGrapher.h"


@implementation ExampleTests

- (void)setUp
{
    self.exampleArray = @[@19, @21, @89.577, @69.9, @1, @0, @-23.3];

    self.barGrapher = [[MBBarGrapher alloc] initWithValues:self.exampleArray];
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testMinValue
{
    STAssertEqualObjects(@-23.3, [self.barGrapher minValue], @"Minimum value calculation is incorrect");
}

- (void)testMaxValue
{
    STAssertEqualObjects(@89.577, [self.barGrapher maxValue], @"Maximum value calculation is incorrect");
}

- (void)testDynamicRange
{
    CGFloat minValue = -23.3;
    CGFloat maxValue = 89.577;
    
    CGFloat distanceBetweenValues = maxValue - minValue;
    
    STAssertEqualObjects(@(ABS(distanceBetweenValues)), @([self.barGrapher dynamicRange]), @"Dynamic range calculation is incorrect");
}


@end
