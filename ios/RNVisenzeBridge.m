
#import "RNVisenzeBridge.h"
#import "ViSearchSDK/ViSearchAPI.h"

@interface RNVisenzeBridge ()
@end
@implementation RNVisenzeBridge

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}
RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(start:(NSString *)appKey) {
    [ViSearchAPI setupAppKey:appKey];
    ViSearchClient *client = [ViSearchAPI defaultClient];
    
//    SearchParams *searchParams = [[SearchParams alloc] init];
//    searchParams.imName = @"11013040_ae";
//
//    [[ViSearchAPI defaultClient] searchWithImageId:searchParams success:^(NSInteger statusCode, ViSearchResult *data, NSError *error) {
//         NSLog(@"Result %@", data);
//         // Do something when request succeeds
//     } failure:^(NSInteger statusCode, ViSearchResult *data, NSError *error) {
//         // Do something when request fails
//     }];
};

- (NSString *)getEventName {
    return @"VisenzeResultEvent";
}


- (NSArray<NSString *> *)supportedEvents {
    return @[[self getEventName]];
}


RCT_EXPORT_METHOD(searchById:(NSString *)id) {
    SearchParams *searchParams = [[SearchParams alloc] init];
    searchParams.imName = id;
    
    [[ViSearchAPI defaultClient] searchWithImageId:searchParams success:^(NSInteger statusCode, ViSearchResult *data, NSError *error) {
        NSLog(@"Result-ID %@", data);
        // Do something when request succeeds
    } failure:^(NSInteger statusCode, ViSearchResult *data, NSError *error) {
        // Do something when request fails
    }];
};

RCT_EXPORT_METHOD(searchByUrl:(NSString *)url limitDetection:(NSString *)value) {
    UploadSearchParams *uploadSearchParams = [[UploadSearchParams alloc] init];
    uploadSearchParams.imageUrl = url;
    uploadSearchParams.detection = value;
    uploadSearchParams.settings = [ImageSettings defaultSettings];
    
    [[ViSearchAPI defaultClient]
     searchWithImageUrl:uploadSearchParams
     success:^(NSInteger statusCode, ViSearchResult *data, NSError *error) {
         NSLog(@"Result-URL %@", data);
         // Do something when request succeeds
     } failure:^(NSInteger statusCode, ViSearchResult *data, NSError *error) {
         // Do something when request fails
     }];
};

RCT_EXPORT_METHOD(searchByPath:(NSString *)path limitDetection:(NSString *)value) {
    UIImage *image = [UIImage imageNamed:path];
    
    UploadSearchParams *uploadSearchParams = [[UploadSearchParams alloc] init];
    uploadSearchParams.imageFile = image;
    uploadSearchParams.detection = value;
    uploadSearchParams.settings = [ImageSettings defaultSettings];
    
    [[ViSearchAPI defaultClient]
     searchWithImageData:uploadSearchParams
     success:^(NSInteger statusCode, ViSearchResult *data, NSError *error) {
         NSLog(@"Result-Path %@", data);
         // Do something when request succeeds
     } failure:^(NSInteger statusCode, ViSearchResult *data, NSError *error) {
         // Do something when request fails
     }];
};

RCT_EXPORT_METHOD(searchByUri:(NSString *)uri limitDetection:(NSString *)value) {
    
};

RCT_EXPORT_METHOD(searchByColor:(NSString *)hexString) {
    ColorSearchParams *colorSearchParams = [[ColorSearchParams alloc] init];
    colorSearchParams.color = hexString;
    
    [[ViSearchAPI defaultClient]
     searchWithColor:colorSearchParams
     success:^(NSInteger statusCode, ViSearchResult *data, NSError *error) {
         NSLog(@"Result-Color %@", data);
         // Do something when request succeeds
     } failure:^(NSInteger statusCode, ViSearchResult *data, NSError *error) {
         // Do something when request fails
     }];
};

RCT_EXPORT_METHOD(trackSearchResultClickEvent:(NSString *)imageName withRequestId:(NSString *)requestID) {
    TrackParams* params = [TrackParams createWithReqId:requestID andAction:@"click"];
    params.imName = imageName;
    [[ViSearchAPI defaultClient] track:params completion:^(BOOL success) {
        NSLog(@"Track Complete");
    }];
};

@end
  
