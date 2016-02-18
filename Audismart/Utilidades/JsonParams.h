//
//  JsonParams.h
//  Audismart
//
//  Created by Dayana Martinez on 16-02-16.
//  Copyright © 2016 Audismart. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonParams : NSObject

- (NSString *)createRequets:(NSDictionary *)queryDictionary;
- (NSString *)createResponse:(NSString *)response;

@end
