//
//  RadarView.h
//  TechRadar
//
//  Created by Magnus Ernstsson on 2012-10-25.
//  Copyright (c) 2012 ThoughtWorks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Radar.h"
#import "RadarViewDelegate.h"

@interface RadarView : UIView
-(void) hideCircle:(NSInteger) inRadius AndOuter:(NSInteger) outRadius;
-(void) searchRadar:(NSString*) searchkey;
-(void) showAllItems;
-(void) updateWithRadar:(Radar*)radar;
@property Radar *radar;
@property (nonatomic, assign) id<RadarViewDelegate>delegate;
@property (nonatomic, assign) NSInteger innerRadius;
@property (nonatomic, assign) NSInteger outerRadius;
@property (nonatomic, strong) NSString *searchkey;
@property (nonatomic,strong) NSMutableArray *quadrantViews;
@end
