#import <Foundation/Foundation.h>

@class RadarView;
@class ItemView;

@protocol RadarViewDelegate <NSObject>
-(void)radarView:(RadarView*)radarView didSelectItem:(ItemView*)itemView;
@end
