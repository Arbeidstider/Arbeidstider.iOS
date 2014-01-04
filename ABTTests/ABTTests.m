//
//  ABTTests.m
//  ABTTests
//
//  Created by Oscar Apeland on 23.09.13.
//  Copyright (c) 2013 Oscar Apeland. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AFFNManager.h"
#import "ABTPerson.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ABTTests : XCTestCase
@property (retain) NSMutableDictionary *params;
@end

@implementation ABTTests

- (void)setUp
{
    [super setUp];
    NSLog(@"setUp");
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testTest{
    
    self.params = [[NSMutableDictionary alloc]init];
    [self.params setObject:@"62560772-CFD8-4DDB-8CE3-3F37638C4327" forKey:@"UserID"];
    [self.params setObject:@"2013,9,1" forKey:@"StartDate"];
    [self.params setObject:@"2013,12,31" forKey:@"EndDate"];
    NSLog(@"SOMETHING IS HAPPENING");
    AFFNRequest *request = [AFFNRequest requestWithConnectionType:kAFFNGet andURL:@"http://services.arbeidstider.no/timesheets" andParams:_params withCompletion:^(AFFNCallbackObject *result){
        
        NSError *error = nil;
        NSMutableArray *JSONArray = [NSJSONSerialization JSONObjectWithData:result.data options:kNilOptions error:&error];//her er json lagra
        NSLog(@"%@",JSONArray);
        
        if(error)NSLog(@"Error: %@",error);
        
        //Data comes back as NSData so it's up to you to parse the response into whatever object type you need
    } andFailure:^(NSError *error){
        //Callback block for failure
        NSLog(@"failed");
        NSLog(@"Error: %@",error);
        
    }];
    
    [[AFFNManager sharedManager] addNetworkOperation:request];

}

@end
