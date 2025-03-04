// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License.

#import <Foundation/Foundation.h>

static NSString *const kSASCustomizedUpdateAlertKey = @"kSASCustomizedUpdateAlertKey";
static NSString *const kMSChildTransmissionTargetTokenKey = @"kMSChildTransmissionTargetToken";
static NSString *const kMSTransmissionIterval = @"kMSTransmissionIterval";
static NSString *const kMSTargetToken1 = @"602c2d529a824339bef93a7b9a035e6a-"
                                         @"a0189496-cc3a-41c6-9214-"
                                         @"b479e5f44912-6819";
static NSString *const kMSTargetToken2 = @"902923ebd7a34552bd7a0c33207611ab-"
                                         @"a48969f4-4823-428f-a88c-"
                                         @"eff15e474137-7039";
static NSString *const kMSSwiftTargetToken = @"1dd3a9a64e144fcbbd4ce31c5def22e0"
                                             @"-e57d4574-c5e7-4f89-a745-"
                                             @"b2e850b54185-7090";
static NSString *const kMSSwiftRuntimeTargetToken = @"238db5abfbaa4c299b78dd539f78b829-cd10afb7-0ec2-496f-ac8a-c21974fbb82c-"
                                                    @"7564";
#if ACTIVE_COMPILATION_CONDITION_PUPPET
static NSString *const kMSObjCTargetToken = @"09855e8251634d618c1d8ef3325e3530-"
                                            @"8c17b252-f3c1-41e1-af64-"
                                            @"78a72d13ac22-6684";
static NSString *const kMSObjCRuntimeTargetToken = @"b9bb5bcb40f24830aa12f681e6462292-10b4c5da-67be-49ce-936b-8b2b80a83a80-"
                                                   @"7868";
#else
static NSString *const kMSObjCTargetToken = @"5a06bf4972a44a059d59c757e6d0b595-"
                                            @"cb71af5d-2d79-4fb4-b969-"
                                            @"01840f1543e9-6845";
static NSString *const kMSObjCRuntimeTargetToken = @"1aa046cfdc8f49bdbd64190290caf7dd-ba041023-af4d-4432-a87e-eb2431150797-"
                                                   @"7361";
#endif

static NSString *const kMSPuppetAppSecret = @"65dc3680-7325-4000-a0e7-dbd2276eafd1";
static NSString *const kMSObjcAppSecret = @"3ccfe7f5-ec01-4de5-883c-f563bbbe147a";
static NSString *const kMSSwiftAppSecret = @"0dbca56b-b9ae-4d53-856a-7c2856137d85";
static NSString *const kMSStartTargetKey = @"startTarget";
static NSString *const kMSStorageMaxSizeKey = @"storageMaxSize";
static NSNotificationName const kUpdateAnalyticsResultNotification = @"updateAnalyticsResult";
static NSString *const kMSUserIdKey = @"userId";
static NSString *const kMSLogUrl = @"logUrl";
static NSString *const kMSAppSecret = @"appSecret";
static NSString *const kMSUserIdentity = @"userIdentity";

#ifdef SQLITE_DEFAULT_PAGE_SIZE
static int const kMSStoragePageSize = SQLITE_DEFAULT_PAGE_SIZE;
#else
static int const kMSStoragePageSize = 4096;
#endif

static NSString *const kMSIntLogUrl = @"https://in-integration.dev.avalanch.es";
static NSString *const kMSIntConfigUrl = @"https://config-integration.dev.avalanch.es";
static NSString *const kMSIntTokenExchangeUrl = @"https://token-exchange-mbaas-integration.dev.avalanch.es/v0.1";
static NSString *const kMSIntApiUrl = @"https://api-gateway-core-integration.dev.avalanch.es/v0.1";
static NSString *const kMSIntInstallUrl = @"https://install.portal-server-core-integration.dev.avalanch.es";
