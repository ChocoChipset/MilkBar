//
//  MBBarGrapher.h
//  Example
//
//  Created by Hector Zarate on 5/3/13.
//  Copyright (c) 2013 Hector Zarate. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBBarGrapher : NSObject

@property (nonatomic, strong, readonly) NSArray *allValues;
@property (nonatomic, unsafe_unretained) CGFloat percentageOfSpaceBetweenBars;


-(id) initWithValues:(NSArray *)paramValues;

@end
