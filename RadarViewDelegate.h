//
//  RadarViewDelegate.h
//  TechRadar
//
//  Created by Magnus Ernstsson on 2012-10-25.
//  Copyright (c) 2012 ThoughtWorks. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RadarView;
@class ItemView;

@protocol RadarViewDelegate <NSObject>
-(void)radarView:(RadarView*)radarView didSelectItem:(ItemView*)itemView;
@end
