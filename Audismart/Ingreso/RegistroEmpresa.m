//
//  RegistroEmpresa.m
//  Aosmart
//
//  Created by Raúl Gómez on 7/07/16.
//  Copyright © 2016 Audismart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegistroEmpresa.h"

@interface RegistroEmpresa ()

@end

@implementation RegistroEmpresa

@synthesize autocompleteUrls;
@synthesize autocompleteDocumentosTableView;
@synthesize autocompleteCategoriaTableView;
@synthesize autocompletePeriodicidadTableView;
@synthesize scrollView;
@synthesize tfNombreEmpresa;
@synthesize tfDepartamento;
@synthesize tfCiudad;
@synthesize tfTipodocumento;
@synthesize tfNumeroDocumento;
@synthesize tfFechaRegistroMercantil;
@synthesize tfIngresos;
@synthesize tfPeriodicidad;
@synthesize tfRegimen;
@synthesize switchImpuesto;
@synthesize switchContribuyente;

NSMutableArray *dataDocumentoUI;
NSMutableArray *dataCategoriaUI;
NSMutableArray *dataPeriodicidadUI;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {

    }
    return self;
}

- (void)GenerarDatos {
    dataDocumentoUI = [[NSMutableArray alloc] init];
    
    NSString* plistDocumentoPath = [[NSBundle mainBundle] pathForResource:@"documento" ofType:@"plist"];
    NSDictionary *dataDocumento = [NSDictionary dictionaryWithContentsOfFile:plistDocumentoPath];
    
    NSString* plistCategoriaPath = [[NSBundle mainBundle] pathForResource:@"categoria" ofType:@"plist"];
    NSDictionary *dataCategoria = [NSDictionary dictionaryWithContentsOfFile:plistCategoriaPath];
    
    NSString* plistPeriodicidadPath = [[NSBundle mainBundle] pathForResource:@"periodicidad" ofType:@"plist"];
    NSDictionary *dataPeriodicidad = [NSDictionary dictionaryWithContentsOfFile:plistPeriodicidadPath];
    
    for (NSString *key in dataDocumento){
        [dataDocumentoUI addObject:[NSString stringWithFormat:@"%@ (%@)", key, [dataDocumento valueForKey:key]]];
        NSLog(@"%@ (%@)", key, [dataDocumento valueForKey:key]);
    }
    
    for (NSString *key in dataCategoria){
        [dataCategoriaUI addObject:[NSString stringWithFormat:@"%@ (%@)", key, [dataCategoria valueForKey:key]]];
        NSLog(@"%@ (%@)", key, [dataCategoria valueForKey:key]);
    }
    
    for (NSString *key in dataPeriodicidad){
        [dataPeriodicidadUI addObject:[NSString stringWithFormat:@"%@ (%@)", key, [dataPeriodicidad valueForKey:key]]];
        NSLog(@"%@ (%@)", key, [dataPeriodicidad valueForKey:key]);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Initialize Data
    self.tfTipodocumento.delegate = self;
    self.tfPeriodicidad.delegate = self;
    self.tfRegimen.delegate = self;
    
    self.autocompleteUrls = [[NSMutableArray alloc] init];
    
    [self GenerarDatos];
    
    
    // Documentos
    autocompleteDocumentosTableView = [[UITableView alloc] initWithFrame:CGRectMake(tfTipodocumento.frame.origin.x, tfTipodocumento.frame.origin.y + tfTipodocumento.frame.size.height, tfTipodocumento.frame.size.width, 120) style:UITableViewStylePlain];
    autocompleteDocumentosTableView.delegate = self;
    autocompleteDocumentosTableView.dataSource = self;
    autocompleteDocumentosTableView.scrollEnabled = YES;
    autocompleteDocumentosTableView.hidden = YES;
    [self.scrollView addSubview:autocompleteDocumentosTableView];
    
    // Periodicidad
    autocompletePeriodicidadTableView = [[UITableView alloc] initWithFrame:CGRectMake(tfPeriodicidad.frame.origin.x, tfPeriodicidad.frame.origin.y + tfPeriodicidad.frame.size.height, tfPeriodicidad.frame.size.width, 120) style:UITableViewStylePlain];
    autocompletePeriodicidadTableView.delegate = self;
    autocompletePeriodicidadTableView.dataSource = self;
    autocompletePeriodicidadTableView.scrollEnabled = YES;
    autocompletePeriodicidadTableView.hidden = YES;
    [self.scrollView addSubview:autocompletePeriodicidadTableView];
    
    // Catergoria/Regimen
    autocompleteCategoriaTableView = [[UITableView alloc] initWithFrame:CGRectMake(tfRegimen.frame.origin.x, tfRegimen.frame.origin.y + tfRegimen.frame.size.height, tfRegimen.frame.size.width, 120) style:UITableViewStylePlain];
    autocompleteCategoriaTableView.delegate = self;
    autocompleteCategoriaTableView.dataSource = self;
    autocompleteCategoriaTableView.scrollEnabled = YES;
    autocompleteCategoriaTableView.hidden = YES;
    [self.scrollView addSubview:autocompleteCategoriaTableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)searchAutocompleteEntriesWithSubstring:(NSString *)substring Numero:(NSUInteger) numero {
    
    // Put anything that starts with this substring into the autocompleteUrls array
    // The items in this array is what will show up in the table view
    [autocompleteUrls removeAllObjects];
    
    switch (numero) {
        case 3: //Tipo documento
            for(NSString *curString in dataDocumentoUI) {
                NSRange substringRange = [curString rangeOfString:substring];
                if (substringRange.location == 0) {
                    [autocompleteUrls addObject:curString];
                }
            }
            [autocompleteDocumentosTableView reloadData];
            break;
            
        case 4: //Periodicidad
            for(NSString *curString in dataPeriodicidadUI) {
                NSRange substringRange = [curString rangeOfString:substring];
                if (substringRange.location == 0) {
                    [autocompleteUrls addObject:curString];
                }
            }
            [autocompletePeriodicidadTableView reloadData];
            break;
        
        case 5: //Regimen
            for(NSString *curString in dataCategoriaUI) {
                NSRange substringRange = [curString rangeOfString:substring];
                if (substringRange.location == 0) {
                    [autocompleteUrls addObject:curString];
                }
            }
            [autocompleteCategoriaTableView reloadData];
            break;
            
        default:
            break;
    }
}

#pragma mark UITextFieldDelegate methods

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString *substring = [NSString stringWithString:textField.text];
    substring = [substring stringByReplacingCharactersInRange:range withString:string];
    [self searchAutocompleteEntriesWithSubstring:substring Numero:textField.tag];
    
    switch (textField.tag) {
        case 3: //Tipo documento
            autocompleteDocumentosTableView.hidden = NO;
            if([autocompleteUrls count] == 0)
                autocompleteDocumentosTableView.hidden = YES;
            break;
            
        case 4: //Periodicidad
            autocompletePeriodicidadTableView.hidden = NO;
            if([autocompleteUrls count] == 0)
                autocompletePeriodicidadTableView.hidden = YES;
            break;
            
        case 5: //Regimen
            autocompleteCategoriaTableView.hidden = NO;
            if([autocompleteUrls count] == 0)
                autocompleteCategoriaTableView.hidden = YES;
            break;
        default:
            break;
    }
    
    return YES;
}

#pragma mark UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section {
    return autocompleteUrls.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    static NSString *AutoCompleteRowIdentifier = @"AutoCompleteRowIdentifier";
    cell = [tableView dequeueReusableCellWithIdentifier:AutoCompleteRowIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc]
                 initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AutoCompleteRowIdentifier] init];
    }
    
    cell.textLabel.text = [autocompleteUrls objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    tfTipodocumento.text = selectedCell.textLabel.text;
    
    autocompleteDocumentosTableView.hidden = YES;
    autocompletePeriodicidadTableView.hidden = YES;
    autocompleteCategoriaTableView.hidden = YES;
}
@end