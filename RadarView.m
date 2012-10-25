//
//  RadarView.m
//  TechRadar
//
//  Created by Magnus Ernstsson on 2012-10-25.
//  Copyright (c) 2012 ThoughtWorks. All rights reserved.
//

#import "RadarView.h"
#import "QuadrantView.h"
#import "CircleView.h"
#import "ItemView.h"
#import "AppConstants.h"

@implementation RadarView
@synthesize radar;
@synthesize quadrantViews;
@synthesize innerRadius,outerRadius;
@synthesize searchkey;

- (id)initWithFrame:(CGRect)frame WithRadar:(Radar*)newRadar {
    self = [super initWithFrame:frame];
    if (self) {
        self.radar = newRadar;
        self.innerRadius=0.0;
        self.outerRadius=400.0;
        self.searchkey = @"";
        self.quadrantViews = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void) updateWithRadar:(Radar*)newRadar {
    self.radar = newRadar;
    self.quadrantViews = [[NSMutableArray alloc] init];
    [self addQuadrants];
    [self hideCircle:0.0 AndOuter:400.0];
    [self showAllItems];
}


-(void) searchRadar:(NSString*) newSearchkey {
    self.searchkey = newSearchkey;
    [self update];
}

-(void)update {
    NSString *newSearchkey = [self.searchkey stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ];
    newSearchkey = [newSearchkey lowercaseString];
    for(QuadrantView *quadrantView in self.quadrantViews){
        NSArray *subViews = quadrantView.subviews;
        for(ItemView *subView in subViews){
            NSInteger ratioRadius = RADAR_RATIO*subView.radius;
            if(ratioRadius > self.innerRadius*RADAR_RATIO && ratioRadius < self.outerRadius*RADAR_RATIO) {
                if([self.searchkey length] > 0) {
                    NSString *blipName = [subView blipName];
                    NSString *blipDesc = [subView description];
                    blipName = [blipName lowercaseString];
                    if ([blipName rangeOfString:newSearchkey].location == NSNotFound && [blipDesc rangeOfString:newSearchkey].location == NSNotFound) {
                        [UIView animateWithDuration:0.3 animations:^() {
                            subView.alpha = 0.0;
                        }];
                    } else {
                        [UIView animateWithDuration:0.3 animations:^() {
                            subView.alpha = 1.0;
                        }];
                    }
                }else {
                    [UIView animateWithDuration:0.3 animations:^() {
                        subView.alpha = 1.0;
                    }];
                }
            }else {
                [UIView animateWithDuration:0.3 animations:^() {
                    subView.alpha = 0.0;
                }];
            }
        }
    }
}

-(void) showAllItems {
    [self hideCircle:0.0 AndOuter:400.0];
}

-(void) hideCircle:(NSInteger) inRadius AndOuter:(NSInteger) outRadius {
    self.innerRadius = inRadius;
    self.outerRadius = outRadius;
    [self update];
 }

-(void) bindQuadrantSingleTap:(QuadrantView*)quadrantView {
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    singleTap.numberOfTapsRequired = 1;
    [quadrantView addGestureRecognizer:singleTap];
}

- (void)singleTap:(UITapGestureRecognizer *)recognizer  {
    QuadrantView *quadrantView = (QuadrantView *)recognizer.view;
    [quadrantView resize:self.frame];
}

-(IBAction) displayItemDetails:(UIGestureRecognizer*)sender {
    [self.delegate radarView:self didSelectItem:(ItemView*)sender.view];
}

-(void) bindItemTap: (QuadrantView*)quadrantView {
    NSArray *subViews = quadrantView.subviews;
    for(CircleView *subView in subViews){
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(displayItemDetails:)];
        [singleTap setNumberOfTapsRequired:1];
        [subView setUserInteractionEnabled:YES];
        [subView addGestureRecognizer:singleTap];
    }
}

-(QuadrantView*) quadrantOriginX:(CGFloat)x Y:(CGFloat)y Quadrant:(Quadrant*)quadrant{
    CGRect screenRect = self.frame;
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    CGPoint origin = CGPointMake(x, y);
    CGRect frame = CGRectMake(origin.x, origin.y, screenWidth/2, screenHeight/2);
    
    CGFloat centerX = (x > 0.0 ? 0.0 : screenWidth/2);
    CGFloat centerY = (y > 0 ? 0.0 : screenHeight/2);
    
    QuadrantView *quadrantView = [[QuadrantView alloc]initWithFrame:frame
                                                         WithCenter:CGPointMake(centerX,centerY)
                                                        AndQuadrant:quadrant];
    [self bindQuadrantSingleTap:quadrantView];
    [self bindItemTap:quadrantView];
    
    [self.quadrantViews addObject:quadrantView];
    return quadrantView;
}

-(void) addQuadrants {
    NSMutableArray *allQuadrants = [self.radar quadrants];
    
    CGRect screenRect = self.frame;
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    CGFloat midPointX = screenWidth/2;
    CGFloat midPointY = screenHeight/2;
    
    [self insertSubview:[self quadrantOriginX:0.0 Y:0 Quadrant:[allQuadrants objectAtIndex:0]] atIndex:1];
    [self insertSubview:[self quadrantOriginX:midPointX Y:0 Quadrant:[allQuadrants objectAtIndex:1]] atIndex:1];
    [self insertSubview:[self quadrantOriginX:0.0 Y:midPointY Quadrant:[allQuadrants objectAtIndex:2]] atIndex:1];
    [self insertSubview:[self quadrantOriginX:midPointX Y:midPointY Quadrant:[allQuadrants objectAtIndex:3]] atIndex:1];
}

@end
