//
//  Constantes.m
//  Audismart
//
//  Created by Dayana Martinez on 03-02-16.
//  Copyright © 2016 Audismart. All rights reserved.
//

#import "Constantes.h"

@implementation Constantes

@synthesize urlServicios;

static Constantes *datos = nil;

+ (Constantes*) datos {
    if (datos == nil)
    {
        datos = [[super allocWithZone:NULL] init];
        datos.urlServicios = @"https://aosmart.aosas.com/movil/WS.php";
    }
    return datos;
}

+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self)
    {
        if (datos == nil)
        {
            datos = [super allocWithZone:zone];
            return datos;
        }
    }
    return nil;
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}
/*
- (id)retain {
    return self;
}

- (NSUInteger)retainCount {
    return NSUIntegerMax;  //denotes an object that cannot be released
}


- (id)autorelease {
    return self;
}*/
@end
