//
//  MockUserDefaults.h
//  CardGame
//
//  Created by Vladimir on 07.04.13.
//  Copyright (c) 2013 Vladimir. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MockUserDefaults : NSObject 

@property (strong, nonatomic) NSMutableDictionary* storage;

- (NSDictionary*) dictionaryForKey: (id) key;
- (id) objectForKey: (id) key;

@end
