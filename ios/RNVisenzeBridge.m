
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
    searchParams.getAllFl = true;
    
    [[ViSearchAPI defaultClient] searchWithImageId:searchParams success:^(NSInteger statusCode, ViSearchResult *data, NSError *error) {
        NSMutableArray *metaDataDict = [[NSMutableArray alloc] init];
        for (ImageResult *result in data.imageResultsArray) {
            [metaDataDict addObject:result.metadataDictionary];
        }
        [self sendEventWithName:[self getEventName]
                           body:metaDataDict];
    } failure:^(NSInteger statusCode, ViSearchResult *data, NSError *error) {
    }];
};

RCT_EXPORT_METHOD(searchByUrl:(NSString *)url limitDetection:(NSString *)value) {
    UploadSearchParams *uploadSearchParams = [[UploadSearchParams alloc] init];
    uploadSearchParams.imageUrl = url;
    uploadSearchParams.getAllFl = true;
    uploadSearchParams.detection = value;
    uploadSearchParams.settings = [ImageSettings defaultSettings];
    
    [[ViSearchAPI defaultClient]
     searchWithImageUrl:uploadSearchParams
     success:^(NSInteger statusCode, ViSearchResult *data, NSError *error) {
         NSMutableArray *metaDataDict = [[NSMutableArray alloc] init];
         for (ImageResult *result in data.imageResultsArray) {
             [metaDataDict addObject:result.metadataDictionary];
         }
         [self sendEventWithName:[self getEventName]
                            body:metaDataDict];
     } failure:^(NSInteger statusCode, ViSearchResult *data, NSError *error) {
     }];
};

RCT_EXPORT_METHOD(searchByPath:(NSString *)path limitDetection:(NSString *)value) {
    UIImage *image = [UIImage imageNamed:path];
    
    UploadSearchParams *uploadSearchParams = [[UploadSearchParams alloc] init];
    uploadSearchParams.imageFile = image;
    uploadSearchParams.getAllFl = true;
    uploadSearchParams.detection = value;
    uploadSearchParams.settings = [ImageSettings defaultSettings];
    
    [[ViSearchAPI defaultClient]
     searchWithImageData:uploadSearchParams
     success:^(NSInteger statusCode, ViSearchResult *data, NSError *error) {
         NSMutableArray *metaDataDict = [[NSMutableArray alloc] init];
         for (ImageResult *result in data.imageResultsArray) {
             [metaDataDict addObject:result.metadataDictionary];
         }
         [self sendEventWithName:[self getEventName]
                            body:metaDataDict];
     } failure:^(NSInteger statusCode, ViSearchResult *data, NSError *error) {
     }];
};

RCT_EXPORT_METHOD(searchByUri:(NSString *)uri limitDetection:(NSString *)value page:(nonnull NSNumber *)page filter:(NSDictionary *)params) {
    
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:uri]]];
    UploadSearchParams *uploadSearchParams = [[UploadSearchParams alloc] init];
    
    uploadSearchParams.page = [page intValue];
    uploadSearchParams.limit = 20;
    
    uploadSearchParams.fq = [params mutableCopy];
    
    uploadSearchParams.imageFile = image;
    uploadSearchParams.getAllFl = true;
    uploadSearchParams.detection = value;
    uploadSearchParams.settings = [ImageSettings defaultSettings];
    
    [[ViSearchAPI defaultClient]
     searchWithImageData:uploadSearchParams
     success:^(NSInteger statusCode, ViSearchResult *data, NSError *error) {
         NSMutableArray *metaDataDict = [[NSMutableArray alloc] init];
         NSMutableArray *imageData = [[NSMutableArray alloc] init];
         NSMutableArray *productTypeData = [[NSMutableArray alloc] init];
         for (ViSearchProductType *result in data.productTypes) {
             [productTypeData addObject:result.type];
         }
         for (ImageResult *result in data.imageResultsArray) {
             [imageData addObject:result.metadataDictionary];
         }
         [metaDataDict addObject:imageData];
         [metaDataDict addObject:productTypeData];
         [self sendEventWithName:[self getEventName]
                            body:metaDataDict];
     } failure:^(NSInteger statusCode, ViSearchResult *data, NSError *error) {
     }];
};

RCT_EXPORT_METHOD(searchByColor:(NSString *)hexString) {
    ColorSearchParams *colorSearchParams = [[ColorSearchParams alloc] init];
    colorSearchParams.color = hexString;
    colorSearchParams.getAllFl = true;
    
    [[ViSearchAPI defaultClient]
     searchWithColor:colorSearchParams
     success:^(NSInteger statusCode, ViSearchResult *data, NSError *error) {
         NSMutableArray *metaDataDict = [[NSMutableArray alloc] init];
         for (ImageResult *result in data.imageResultsArray) {
             [metaDataDict addObject:result.metadataDictionary];
         }
         [self sendEventWithName:[self getEventName]
                            body:metaDataDict];
     } failure:^(NSInteger statusCode, ViSearchResult *data, NSError *error) {
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


