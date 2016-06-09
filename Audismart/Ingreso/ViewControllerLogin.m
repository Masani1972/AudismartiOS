//
//  ViewControllerLogin.m
//  Audismart
//
//  Created by Dayana Martinez on 03-02-16.
//  Copyright © 2016 Audismart. All rights reserved.
//

#import "ViewControllerLogin.h"
#import "Constantes.h"


@interface ViewControllerLogin ()

@end


@implementation ViewControllerLogin

@synthesize emai;
@synthesize contrasena;
@synthesize jsonParams;

- (void)viewDidLoad {
    [super viewDidLoad];
    jsonParams = [[JsonParams alloc] init];
    contrasena.secureTextEntry = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Activa la peticion
- (IBAction)ingresar:(id)sender {

    NSURL *url = [NSURL URLWithString: @"https://aosmart.aosas.com/movil/WS.php"];//[Constantes datos].urlServicios ];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config  delegate:self delegateQueue:nil];
    

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    NSDictionary *queryDictionary = @{ @"email": emai.text, @"contrasena": [self md5:contrasena.text], @"ACCION": @"LOGIN"};
  
    NSString *params =[jsonParams createRequets:queryDictionary];

    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask * dataTask =[session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    NSLog(@"Response: %@ %@\n", response, error);
                                                    if(error == nil)
                                                    {
                                                        NSString *response =[[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                                                        if([jsonParams createResponse:response]==nil)
                                                        {
                                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                                [self success];
                                                            });
                                                        }else{
                                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                                [self error:[jsonParams createResponse:response]];
                                                            });
                                                        }
                                                    }
                                                }];
    [dataTask resume];
}

-(void)error:(NSString *)message{

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    /*UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleActionSheet]; // 1
    UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"OK"
                                                          style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                          }];
    
    [alert addAction:firstAction];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alert animated:YES completion:nil];
    });*/
}

-(void)success{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"ViewControllerRegistroUser"];
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:vc animated:YES completion:NULL];

}

- (NSString *) md5:(NSString *) input
{
    const char *cStr = [input UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
    
}

@end
