
#if __has_include("RCTBridgeModule.h")
#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>
#else
#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>
#endif

@interface RNVisenzeBridge : RCTEventEmitter <RCTBridgeModule>

@end
  
