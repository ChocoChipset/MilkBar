//
//  MBBarGrapher.m
//  Example
//
//  Created by Hector Zarate on 5/3/13.
//  Copyright (c) 2013 Hector Zarate. All rights reserved.
//

#import "MBBarGrapher.h"

#pragma mark - Class Constants

const CGFloat kPercentageOfSpaceBetweenBarsByDefault = 0.2;

const CGFloat kColorComponentsFillByDefault[4]          = { 0.0, 0.0, 0.0, 1.0 };
const CGFloat kColorComponentsStrokeByDefault[4]        = { 1.0, 1.0, 1.0, 1.0 };
const CGFloat kColorComponentsBackgroundByDefault[4]    = { 0.0, 0.0, 0.0, 0.0 };

#pragma mark -


@interface MBBarGrapher (CoreGraphicsAbstractionLayer)

-(CGImageRef)generateImageReferenceForSize:(CGSize)paramSize;

@end


@implementation MBBarGrapher

#pragma mark - Class Initializers

-(id)init
{
    return [self initWithValues:nil];
}

/* Designated Initializer: */

-(id)initWithValues:(NSArray *)paramValues
{
    self = [super init];
    
    if (self)
    {
        if (!paramValues)
        {
            return nil;
        }
        
        _allValues = paramValues;
        _percentageOfSpaceBetweenBars = kPercentageOfSpaceBetweenBarsByDefault;
        
        _colorSpaceDeviceRGB = CGColorSpaceCreateDeviceRGB();
        
        _backgroundColorReference = CGColorCreate(_colorSpaceDeviceRGB, kColorComponentsBackgroundByDefault);
        _fillColorReference = CGColorCreate(_colorSpaceDeviceRGB, kColorComponentsFillByDefault);
        _strokeColorReference = CGColorCreate(_colorSpaceDeviceRGB, kColorComponentsStrokeByDefault);
    }
    
    return self;
}

-(void)dealloc
{
    CGColorSpaceRelease(_colorSpaceDeviceRGB);
    CGColorRelease(self.backgroundColorReference);
    CGColorRelease(self.fillColorReference);
    CGColorRelease(self.strokeColorReference);
}

#pragma mark - Basic Calculations

-(NSNumber *)minValue
{
    NSNumber *minimum = [self.allValues valueForKeyPath:@"@min.doubleValue"];
    
    return minimum;
}

-(NSNumber *)maxValue
{
    NSNumber *maximum = [self.allValues valueForKeyPath:@"@max.doubleValue"];
    
    return maximum;
}

-(CGFloat)dynamicRange
{
    CGFloat minimumValue = [[self minValue] doubleValue];
    
    CGFloat maximumValue = [[self maxValue] doubleValue];
    
    CGFloat distanceBetweenValues = maximumValue - minimumValue;
    
    return distanceBetweenValues;
}


@end
