//
//  ViewController.m
//  TransferAppleMap
//
//  Created by mac on 16/12/20.
//  Copyright © 2016年 CYC. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface ViewController () <CLLocationManagerDelegate> {

    CLLocationManager *_manager;
    MKMapItem *_prelocation;
    MKMapItem *_toLocation;
    CLLocationCoordinate2D _preCoords;
    CLLocationCoordinate2D _toCoords;

}
@property (weak, nonatomic) IBOutlet UITextField *preLat;
@property (weak, nonatomic) IBOutlet UITextField *preLon;
@property (weak, nonatomic) IBOutlet UITextField *toLat;
@property (weak, nonatomic) IBOutlet UITextField *toLon;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 获取当前位置
    _manager = [[CLLocationManager alloc] init];
    _manager.delegate = self;
    [_manager startUpdatingLocation];
    
    
    
    
    
    
    
    
    
}

// 更新位置了
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {

    // 当前经纬度
    CLLocation *preLocation = locations.firstObject;
    float currentLatitude = preLocation.coordinate.latitude;
    _preLat.text = [NSString stringWithFormat:@"%.8f", currentLatitude];
    float currentLongitude = preLocation.coordinate.longitude;
    _preLon.text = [NSString stringWithFormat:@"%.8f", currentLongitude];
    
    _preCoords = CLLocationCoordinate2DMake(currentLatitude,currentLongitude);


}


// 开启导航
- (IBAction)start:(id)sender {

    if (_toLat.text != nil && _toLon.text != nil) {
        
        float toLatitude = [_toLat.text floatValue];
        float toLongitude = [_toLon.text floatValue];
        _toCoords = CLLocationCoordinate2DMake(toLatitude, toLongitude);
        
        // 目的地
        _toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:_toCoords
                                                                                           addressDictionary:nil]];
        _toLocation.name = @"目的地";
        
        
        // 起始点与终点
        NSArray *items = [NSArray arrayWithObjects:_prelocation, _toLocation, nil];
        NSDictionary *options = @{ MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving,
                                   MKLaunchOptionsMapTypeKey: [NSNumber numberWithInteger:MKMapTypeStandard],
                                   MKLaunchOptionsShowsTrafficKey:@YES };
        [MKMapItem openMapsWithItems:items launchOptions:options];
        
    }

}




@end
