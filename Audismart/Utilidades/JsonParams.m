//
//  JsonParams.m
//  Audismart
//
//  Created by Dayana Martinez on 16-02-16.
//  Copyright © 2016 Audismart. All rights reserved.
//

#import "JsonParams.h"

@interface JsonParams ()

@end

@implementation JsonParams

- (NSString *)createRequets:(NSDictionary *)queryDictionary{
    NSURLComponents *components = [NSURLComponents componentsWithString:@""];
    
    NSMutableArray *queryItems = [NSMutableArray array];
    for (NSString *key in queryDictionary) {
        [queryItems addObject:[NSURLQueryItem queryItemWithName:key value:queryDictionary[key]]];
    }
    components.queryItems = queryItems;
    NSURL *url = components.URL;
    return [url absoluteString];
}

- (NSString *)createResponse:(NSString *)response{
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
    NSString *categoryString = result[@"error"];//[result[@"error"] stringValue];
    if([categoryString isEqualToString:@"0"])
        return @"";
    else
        return result[@"message"];
    
}

- (NSDictionary *)createResponseDictionary:(NSString *)response{
    NSError *er = nil;
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&er];
    if (er != nil) {
        return nil;
    }
    return result;
    
}

@end
