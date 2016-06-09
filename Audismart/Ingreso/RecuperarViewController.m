//
//  RecuperarViewController.m
//  Audismart
//
//  Created by Dayana Martinez on 30-01-16.
//  Copyright © 2016 Audismart. All rights reserved.
//

#import "RecuperarViewController.h"
#import "Constantes.h"

@interface RecuperarViewController ()

@end

@implementation RecuperarViewController

@synthesize textFieldEmail;
@synthesize buttonEnviarContrasena;
@synthesize jsonParams;

    
- (void)viewDidLoad {
    [super viewDidLoad];
    jsonParams = [[JsonParams alloc] init];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonEnviarContrasena:(id)sender {

    NSURL *url = [NSURL URLWithString: [Constantes datos].urlServicios ];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config  delegate:self delegateQueue:nil];
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    NSDictionary *queryDictionary = @{ @"email": textFieldEmail.text, @"ACCION": @"RECUPERAR CONTRASENA"};
    
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
}

-(void)success{
    /*UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"ViewControllerRegistroUser"];
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:vc animated:YES completion:NULL];*/
    
}
@end
