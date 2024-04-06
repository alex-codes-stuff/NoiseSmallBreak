#import "Vibrate.h"
#import <AudioToolbox/AudioServices.h>

@implementation Vibrate

// params are ignored
-(void)VibrateOnce :(double)len :(double)strenght{
  AudioServicesPlaySystemSound(1519);
}

@end

