//
//  Constantes.h
//  Audismart
//
//  Created by Dayana Martinez on 03-02-16.
//  Copyright © 2016 Audismart. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Constantes : NSObject
{
    NSString *urlServicios;
}

@property (nonatomic, retain) NSString *urlServicios;

+ (Constantes*) datos;

@end
