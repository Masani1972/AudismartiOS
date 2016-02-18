//
//  ViewControllerLogin.m
//  Audismart
//
//  Created by Dayana Martinez on 03-02-16.
//  Copyright © 2016 Audismart. All rights reserved.
//

#import "ViewControllerLogin.h"


@interface ViewControllerLogin ()

@end


@implementation ViewControllerLogin

@synthesize emai;
@synthesize contrasena;

JsonParams* jsonParams;

- (void)viewDidLoad {
    [super viewDidLoad];
      jsonParams = [[JsonParams alloc] init];
    contrasena.secureTextEntry = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)ingresar:(id)sender {

    NSURL *url = [NSURL URLWithString:@"http://aosmart.aosas.com/movil/WS.php"];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config  delegate:self delegateQueue:nil];
    

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    NSDictionary *queryDictionary = @{ @"email": emai.text, @"contrasena": contrasena.text, @"ACCION": @"LOGIN"};
  
    NSString *params =[jsonParams createRequets:queryDictionary];

    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask * dataTask =[session dataTaskWithRequest:request
                                                       completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                           NSLog(@"Response:%@ %@\n", response, error);
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

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleActionSheet]; // 1
    UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"OK"
                                                          style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                          }];
    
    [alert addAction:firstAction];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alert animated:YES completion:nil]; 
    });
}

-(void)success{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"ViewControllerRegistroUser"];
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:vc animated:YES completion:NULL];

}



@end
