//
//  MBBarGrapher.h
//  Example
//
//  Created by Hector Zarate on 5/3/13.
//  Copyright (c) 2013 Hector Zarate. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBBarGrapher : NSObject

@property (nonatomic, unsafe_unretained) CGColorRef backgroundColorReference;
@property (nonatomic, unsafe_unretained) CGColorRef fillColorReference;
@property (nonatomic, unsafe_unretained) CGColorRef strokeColorReference;

@property (nonatomic, strong, readonly) NSArray *allValues;
@property (nonatomic, unsafe_unretained) CGFloat percentageOfSpaceBetweenBars;


-(id) initWithValues:(NSArray *)paramValues;

-(UIImage *) generateImageForSize:(CGSize)paramSize;

-(CGFloat) dynamicRange;
-(NSNumber *) maxValue;
-(NSNumber *) minValue;

@end
