//
//  EmitterView.m
//  CAEmitterDemo
//
//  Created by rl on 14-7-7.
//  Copyright (c) 2014年 rl. All rights reserved.
//

#import "FireworksView.h"

@implementation FireworksView

- (void)launchFirework{
   	
	//Load the spark image for the particle
	
	CAEmitterLayer *mortor = [CAEmitterLayer layer];
    //例子发射位置
	mortor.emitterPosition = CGPointMake(self.bounds.size.width/2, self.bounds.size.height*(.75));
    //发射源的尺寸大小
    mortor.emitterSize = CGSizeMake(100, 100);
    //发射源的形状
    mortor.emitterShape = kCAEmitterLayerCircle;
	mortor.renderMode = kCAEmitterLayerAdditive;
	
	//Invisible particle representing the rocket before the explosion
	CAEmitterCell *rocket = [CAEmitterCell emitterCell];
	rocket.emissionLongitude = -M_PI / 2;
	rocket.emissionLatitude = 0;
	rocket.lifetime = 1.6;
    rocket.scale = 0.4;
	rocket.birthRate = 1;
	rocket.velocity = 300;
	rocket.velocityRange = 100;
	rocket.yAcceleration = 250;
	rocket.emissionRange = M_PI / 6;
	rocket.color = CGColorCreateCopy([UIColor colorWithRed:.5 green:.5 blue:.5 alpha:.5].CGColor);
	rocket.redRange = 0.5;
	rocket.greenRange = 0.5;
	rocket.blueRange = 0.5;
//    rocket.contents = (id)[UIImage imageNamed:@"fire.png"].CGImage;

    //Name the cell so that it can be animated later using keypath
	[rocket setName:@"rocket"];
	
	//Flare particles emitted from the rocket as it flys
	CAEmitterCell *flare = [CAEmitterCell emitterCell];
	flare.contents = (id)[UIImage imageNamed:@"fire.png"].CGImage;
	flare.emissionLongitude = (4 * M_PI) / 2;
	flare.scale = 0.3;
	flare.velocity = 50;
	flare.birthRate = 300;
	flare.lifetime = 0.5;
	flare.zAcceleration = 350;
	flare.emissionRange = M_PI / 7;
	flare.alphaSpeed = -0.7;
	flare.scaleSpeed = -0.1;
	flare.scaleRange = 0.1;
//	flare.beginTime = 0.01;
	flare.duration = 0.7;
	
	//The particles that make up the explosion
	CAEmitterCell *firework = [CAEmitterCell emitterCell];
	firework.contents = (id)[UIImage imageNamed:@"tspark.png"].CGImage;
	firework.birthRate = 8888;
	firework.scale = 1.2;
	firework.velocity = 150;
	firework.lifetime = 1;
	firework.alphaSpeed = -0.2;
	firework.yAcceleration = 80;
	firework.beginTime = 1.5;
	firework.duration = 0.1;
	firework.emissionRange = 2 * M_PI;
	firework.scaleSpeed = -0.1;
	firework.spin = 2;
	
	//Name the cell so that it can be animated later using keypath
	[firework setName:@"firework"];
	
	//preSpark is an invisible particle used to later emit the spark
	CAEmitterCell *preSpark = [CAEmitterCell emitterCell];
	preSpark.birthRate = 50;
	preSpark.velocity = firework.velocity * 0.70;
	preSpark.lifetime = 0.5;
	preSpark.yAcceleration = firework.yAcceleration * 0.85;
	preSpark.beginTime = firework.beginTime - 0.2;
	preSpark.emissionRange = firework.emissionRange;
	preSpark.greenSpeed = 100;
	preSpark.blueSpeed = 100;
	preSpark.redSpeed = 100;
    preSpark.contents = (id)[UIImage imageNamed:@"tspark.png"].CGImage;
    preSpark.scale = 1;
    
	//Name the cell so that it can be animated later using keypath
	[preSpark setName:@"preSpark"];
	
	//The 'sparkle' at the end of a firework
	CAEmitterCell *spark = [CAEmitterCell emitterCell];
	spark.contents = (id)[UIImage imageNamed:@"tspark.png"].CGImage;
	spark.lifetime = 0.2;
	spark.yAcceleration = 250;
	spark.beginTime = 0;
	spark.scale = 1;
	spark.birthRate = 10;
    spark.spin = 20;
	
	preSpark.emitterCells = [NSArray arrayWithObjects:spark, nil];
	rocket.emitterCells = [NSArray arrayWithObjects:flare, firework, preSpark, nil];
	mortor.emitterCells = [NSArray arrayWithObjects:rocket, nil];
	[self.layer addSublayer:mortor];
}

@end
