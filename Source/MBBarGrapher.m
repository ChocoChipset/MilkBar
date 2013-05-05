//
//  MBBarGrapher.m
//  Example
//
//  Created by Hector Zarate on 5/3/13.
//  Copyright (c) 2013 Hector Zarate. All rights reserved.
//

#import "MBBarGrapher.h"

#pragma mark - Class Constants

const CGFloat kPercentageOfSpaceBetweenBarsByDefault    = 0.2;

const NSUInteger kBitsPerComponentForRGBColorSpace = 8;

const CGFloat kColorComponentsFillByDefault[4]          = { 0.0, 0.0, 0.0, 1.0 };
const CGFloat kColorComponentsStrokeByDefault[4]        = { 1.0, 1.0, 1.0, 1.0 };
const CGFloat kColorComponentsBackgroundByDefault[4]    = { 0.0, 0.0, 0.0, 0.0 };

#pragma mark -


@interface MBBarGrapher ()

@property (nonatomic, unsafe_unretained, readonly) CGColorSpaceRef colorSpaceDeviceRGB;

@property (nonatomic, unsafe_unretained) CGColorRef backgroundColorReference;
@property (nonatomic, unsafe_unretained) CGColorRef fillColorReference;
@property (nonatomic, unsafe_unretained) CGColorRef strokeColorReference;

-(CGImageRef)createImageReferenceForSize:(CGSize)paramSize;

@end

#pragma mark -

@implementation MBBarGrapher

#pragma mark - Class Initializers

-(id)init
{
    return [self initWithValues:nil];
}

/* = Designated Initializer: = */

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
    CGColorRelease(_backgroundColorReference);
    CGColorRelease(_fillColorReference);
    CGColorRelease(_strokeColorReference);
}

#pragma mark - Image Generation (iOS)

-(UIImage *)generateImageForSize:(CGSize)paramSize
{
    CGImageRef imageReference = [self createImageReferenceForSize:paramSize];
    
    // TODO: adjust coordinate system!
    
    UIImage *result = [UIImage imageWithCGImage:imageReference];
    
    CGImageRelease(imageReference);
    
    return result;
}

#pragma mark - Image Generation (CoreGraphics)

-(CGImageRef)createImageReferenceForSize:(CGSize)paramSize
{
    const CGFloat totalWidthBetweenBars = (paramSize.width * self.percentageOfSpaceBetweenBars);
    const CGFloat singleBarWidth = (paramSize.width - totalWidthBetweenBars) / [self.allValues count];
    const CGFloat singleSpaceWith = totalWidthBetweenBars / [self.allValues count];

    CGContextRef bitmapContext = CGBitmapContextCreate(NULL,
                                                       paramSize.width,
                                                       paramSize.height,
                                                       kBitsPerComponentForRGBColorSpace,
                                                       kBitsPerComponentForRGBColorSpace * paramSize.width,
                                                       self.colorSpaceDeviceRGB,
                                                       kCGImageAlphaPremultipliedLast);
    
    
    /* == Background == */
    
    CGContextSetFillColorWithColor(bitmapContext, self.backgroundColorReference);
    
    CGContextFillRect(bitmapContext, CGRectMake(0.0, 0.0, paramSize.width, paramSize.height));
    
    /* == Bars == */
    
    CGContextSetFillColorWithColor(bitmapContext, self.fillColorReference);
    CGContextSetStrokeColorWithColor(bitmapContext, self.strokeColorReference);

    CGFloat offsetX = 0.0;
    CGFloat maxValue = [self.maxValue doubleValue]; // avoiding recalculation on each iteration
    
    for (NSUInteger barIndex = 0; barIndex < self.allValues.count; ++barIndex)
    {
        CGFloat barHeight = NormalizeValue([(NSNumber *)[self.allValues objectAtIndex:barIndex] doubleValue],
                                           maxValue,
                                           paramSize.height);
        
        CGRect barRect = CGRectMake(offsetX, 0.0, singleBarWidth, barHeight);
        
        CGContextFillRect(bitmapContext, CGRectIntegral(barRect));
        
        offsetX += singleBarWidth + singleSpaceWith;
    }
    
    
    /* == Image Reference Export == */
    
    CGImageRef result = CGBitmapContextCreateImage(bitmapContext);
    
    CGContextRelease(bitmapContext);
    
    return result;
}

#pragma mark - UIColor Accessors

-(UIColor *)backgroundColor
{
    UIColor *result = [UIColor colorWithCGColor:self.backgroundColorReference];
    
    return result;
}

-(UIColor *)fillColor
{
    UIColor *result = [UIColor colorWithCGColor:self.fillColorReference];
    
    return result;
}

-(UIColor *)strokeColor
{
    UIColor *result = [UIColor colorWithCGColor:self.strokeColorReference];
    
    return result;
}

#pragma mark - UIColor Setters

-(void)setBackgroundColor:(UIColor *)backgroundColor
{
    CGColorRelease(self.backgroundColorReference);
    
    self.backgroundColorReference = CGColorCreateCopy(backgroundColor.CGColor);
}

-(void)setFillColor:(UIColor *)fillColor
{
    CGColorRelease(self.fillColorReference);
    
    self.fillColorReference = CGColorCreateCopy(fillColor.CGColor);
}

-(void)setStrokeColor:(UIColor *)strokeColor
{
    CGColorRelease(self.strokeColorReference);
    
    self.strokeColorReference = CGColorCreateCopy(strokeColor.CGColor);
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

#pragma mark - Other Functions

CGFloat NormalizeValue(CGFloat value, CGFloat maxValue, CGFloat chartHeight)
{
    if (maxValue == 0)
    {
        return NAN;
    }
    
    CGFloat ratio = value / maxValue;
    CGFloat resultHeight = chartHeight * ratio;
    
    return resultHeight;
}


@end