//
//  MBBarGrapher.h
//  Example
//
//  Created by Hector Zarate on 5/3/13.
//  Copyright (c) 2013 Hector Zarate. All rights reserved.
//

#import <Foundation/Foundation.h>

CGFloat NormalizeValue(CGFloat value, CGFloat maxValue, CGFloat chartHeight);

@interface MBBarGrapher : NSObject
{
    CGColorSpaceRef _colorSpaceDeviceRGB;
    
    CGColorRef _backgroundColorReference;
    CGColorRef _fillColorReference;
    CGColorRef _strokeColorReference;
}

@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIColor *fillColor;
@property (nonatomic, strong) UIColor *strokeColor;

@property (nonatomic, strong, readonly) NSArray *allValues;
@property (nonatomic, unsafe_unretained) CGFloat percentageOfSpaceBetweenBars;


-(id) initWithValues:(NSArray *)paramValues;

-(UIImage *) generateImageForSize:(CGSize)paramSize;

-(CGFloat) dynamicRange;
-(NSNumber *) maxValue;
-(NSNumber *) minValue;

@end
