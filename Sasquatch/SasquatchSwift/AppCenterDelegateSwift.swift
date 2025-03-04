// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License.

import AppCenter
import AppCenterAnalytics
import AppCenterCrashes
import AppCenterData
import AppCenterDistribute
import AppCenterAuth
import AppCenterPush

/**
 * Selectors for reflection.
 */
@objc protocol Selectors {
  func sharedInstance() -> MSDistribute
  func showConfirmationAlert(_ releaseDetails: MSReleaseDetails)
  func showDistributeDisabledAlert()
  func delegate() -> MSDistributeDelegate
}

/**
 * AppCenterDelegate implementation in Swift.
 */
class AppCenterDelegateSwift: AppCenterDelegate {

  // MSAppCenter section.
  func isAppCenterEnabled() -> Bool {
    return MSAppCenter.isEnabled()
  }

  func setAppCenterEnabled(_ isEnabled: Bool) {
    MSAppCenter.setEnabled(isEnabled)
  }

  func setCustomProperties(_ customProperties: MSCustomProperties) {
    MSAppCenter.setCustomProperties(customProperties)
  }

  func installId() -> String {
    return MSAppCenter.installId().uuidString
  }

  func appSecret() -> String {
    return kMSSwiftAppSecret
  }

  func setLogUrl(_ logUrl: String?) {
    MSAppCenter.setLogUrl(logUrl);
  }

  func sdkVersion() -> String {
    return MSAppCenter.sdkVersion()
  }

  func isDebuggerAttached() -> Bool {
    return MSAppCenter.isDebuggerAttached()
  }

  func startAnalyticsFromLibrary() {
    MSAppCenter.startFromLibrary(withServices: [MSAnalytics.self])
  }

  func setUserId(_ userId: String?) {
    MSAppCenter.setUserId(userId);
  }
  
  func setCountryCode(_ countryCode: String?) {
    MSAppCenter.setCountryCode(countryCode);
  }

  // Modules section.
  func isAnalyticsEnabled() -> Bool {
    return MSAnalytics.isEnabled()
  }

  func isCrashesEnabled() -> Bool {
    return MSCrashes.isEnabled()
  }

  func isDistributeEnabled() -> Bool {
    return MSDistribute.isEnabled()
  }

  func isAuthEnabled() -> Bool {
    return MSAuth.isEnabled()
  }

  func isPushEnabled() -> Bool {
    return MSPush.isEnabled()
  }

  func setAnalyticsEnabled(_ isEnabled: Bool) {
    MSAnalytics.setEnabled(isEnabled)
  }

  func setCrashesEnabled(_ isEnabled: Bool) {
    MSCrashes.setEnabled(isEnabled)
  }

  func setDistributeEnabled(_ isEnabled: Bool) {
    MSDistribute.setEnabled(isEnabled)
  }

  func setAuthEnabled(_ isEnabled: Bool) {
    MSAuth.setEnabled(isEnabled)
  }

  func setPushEnabled(_ isEnabled: Bool) {
    MSPush.setEnabled(isEnabled)
  }

  // MSAnalytics section.
  func trackEvent(_ eventName: String) {
    MSAnalytics.trackEvent(eventName)
  }

  func trackEvent(_ eventName: String, withProperties properties: Dictionary<String, String>) {
    MSAnalytics.trackEvent(eventName, withProperties: properties)
  }

  func trackEvent(_ eventName: String, withProperties properties: Dictionary<String, String>, flags: MSFlags) {
    MSAnalytics.trackEvent(eventName, withProperties: properties, flags:flags)
  }

  func trackEvent(_ eventName: String, withTypedProperties properties: MSEventProperties) {
    MSAnalytics.trackEvent(eventName, withProperties: properties)
  }

  func trackEvent(_ eventName: String, withTypedProperties properties: MSEventProperties?, flags: MSFlags) {
    MSAnalytics.trackEvent(eventName, withProperties: properties, flags: flags)
  }

  #warning("TODO: Uncomment when trackPage is moved from internal to public")
  func trackPage(_ pageName: String) {
    // MSAnalytics.trackPage(pageName)
  }

  #warning("TODO: Uncomment when trackPage is moved from internal to public")
  func trackPage(_ pageName: String, withProperties properties: Dictionary<String, String>) {
    // MSAnalytics.trackPage(pageName, withProperties: properties)
  }

  func resume() {
    MSAnalytics.resume()
  }

  func pause() {
    MSAnalytics.pause()
  }

  // MSCrashes section.
  func hasCrashedInLastSession() -> Bool {
    return MSCrashes.hasCrashedInLastSession()
  }

  func generateTestCrash() {
    MSCrashes.generateTestCrash()
  }

  // MSDistribute section.
  func showConfirmationAlert() {
    let sharedInstanceSelector = #selector(Selectors.sharedInstance)
    let confirmationAlertSelector = #selector(Selectors.showConfirmationAlert(_:))
    let releaseDetails = MSReleaseDetails();
    releaseDetails.version = "10";
    releaseDetails.shortVersion = "1.0";
    if (MSDistribute.responds(to: sharedInstanceSelector)) {
      let distributeInstance = MSDistribute.perform(sharedInstanceSelector).takeUnretainedValue()
      if (distributeInstance.responds(to: confirmationAlertSelector)) {
        _ = distributeInstance.perform(confirmationAlertSelector, with: releaseDetails)
      }
    }
  }

  func showDistributeDisabledAlert() {
    let sharedInstanceSelector = #selector(Selectors.sharedInstance)
    let disabledAlertSelector = #selector(Selectors.showDistributeDisabledAlert)
    if (MSDistribute.responds(to: sharedInstanceSelector)) {
      let distributeInstance = MSDistribute.perform(sharedInstanceSelector).takeUnretainedValue()
      if (distributeInstance.responds(to: disabledAlertSelector)) {
        _ = distributeInstance.perform(disabledAlertSelector)
      }
    }
  }

  func showCustomConfirmationAlert() {
    let sharedInstanceSelector = #selector(Selectors.sharedInstance)
    let delegateSelector = #selector(Selectors.delegate)
    let releaseDetails = MSReleaseDetails();
    releaseDetails.version = "10";
    releaseDetails.shortVersion = "1.0";
    if (MSDistribute.responds(to: sharedInstanceSelector)) {
      let distributeInstance = MSDistribute.perform(sharedInstanceSelector).takeUnretainedValue()
      let distriuteDelegate = distributeInstance.perform(delegateSelector).takeUnretainedValue()
      _ = distriuteDelegate.distribute?(distributeInstance as? MSDistribute, releaseAvailableWith: releaseDetails)
    }
  }

  // MSAuth section.
  func signIn(_ completionHandler: @escaping (_ signInInformation:MSUserInformation?, _ error:Error?) -> Void) {
    MSAuth.signIn { userInformation, error in
      if error == nil {
        UserDefaults.standard.set(true, forKey: kMSUserIdentity)
        print("Auth.signIn succeeded, accountId=\(userInformation?.accountId ?? "nil")")
      }
      else {
        print("Auth.signIn failed, error=\(String(describing: error))")
      }
      completionHandler(userInformation, error)
    }
  }

  func signOut() {
    MSAuth.signOut()
    UserDefaults.standard.set(false, forKey: kMSUserIdentity)
  }

  // Last crash report section.
  func lastCrashReportIncidentIdentifier() -> String? {
    return MSCrashes.lastSessionCrashReport()?.incidentIdentifier
  }

  func lastCrashReportReporterKey() -> String? {
    return MSCrashes.lastSessionCrashReport()?.reporterKey
  }

  func lastCrashReportSignal() -> String? {
    return MSCrashes.lastSessionCrashReport()?.signal
  }

  func lastCrashReportExceptionName() -> String? {
    return MSCrashes.lastSessionCrashReport()?.exceptionName
  }

  func lastCrashReportExceptionReason() -> String? {
    return MSCrashes.lastSessionCrashReport()?.exceptionReason
  }

  func lastCrashReportAppStartTimeDescription() -> String? {
    return MSCrashes.lastSessionCrashReport()?.appStartTime.description
  }

  func lastCrashReportAppErrorTimeDescription() -> String? {
    return MSCrashes.lastSessionCrashReport()?.appErrorTime.description
  }

  func lastCrashReportAppProcessIdentifier() -> UInt {
    return (MSCrashes.lastSessionCrashReport()?.appProcessIdentifier)!
  }

  func lastCrashReportIsAppKill() -> Bool {
    return (MSCrashes.lastSessionCrashReport()?.isAppKill())!
  }

  func lastCrashReportDeviceModel() -> String? {
    return MSCrashes.lastSessionCrashReport()?.device.model
  }

  func lastCrashReportDeviceOemName() -> String? {
    return MSCrashes.lastSessionCrashReport()?.device.oemName
  }

  func lastCrashReportDeviceOsName() -> String? {
    return MSCrashes.lastSessionCrashReport()?.device.osName
  }

  func lastCrashReportDeviceOsVersion() -> String? {
    return MSCrashes.lastSessionCrashReport()?.device.osVersion
  }

  func lastCrashReportDeviceOsBuild() -> String? {
    return MSCrashes.lastSessionCrashReport()?.device.osBuild
  }

  func lastCrashReportDeviceLocale() -> String? {
    return MSCrashes.lastSessionCrashReport()?.device.locale
  }

  func lastCrashReportDeviceTimeZoneOffset() -> NSNumber? {
    return MSCrashes.lastSessionCrashReport()?.device.timeZoneOffset
  }

  func lastCrashReportDeviceScreenSize() -> String? {
    return MSCrashes.lastSessionCrashReport()?.device.screenSize
  }

  func lastCrashReportDeviceAppVersion() -> String? {
    return MSCrashes.lastSessionCrashReport()?.device.appVersion
  }

  func lastCrashReportDeviceAppBuild() -> String? {
    return MSCrashes.lastSessionCrashReport()?.device.appBuild
  }

  func lastCrashReportDeviceCarrierName() -> String? {
    return MSCrashes.lastSessionCrashReport()?.device.carrierName
  }

  func lastCrashReportDeviceCarrierCountry() -> String? {
    return MSCrashes.lastSessionCrashReport()?.device.carrierCountry
  }

  func lastCrashReportDeviceAppNamespace() -> String? {
    return MSCrashes.lastSessionCrashReport()?.device.appNamespace
  }
  
  // MSData
  
  func listDocumentsWithPartition(_ partitionName: String, documentType: AnyClass, completionHandler: @escaping (_ paginatedDocuments:MSPaginatedDocuments) -> Void) {
    MSData.listDocuments(withType: documentType, partition: partitionName, completionHandler: completionHandler)
  }
  
  func createDocumentWithPartition(_ partitionName: String, documentId: String, document: MSDictionaryDocument, writeOptions: MSWriteOptions, completionHandler: @escaping (_ document:MSDocumentWrapper) -> Void) {
    MSData.create(withDocumentID: documentId, document: document, partition: partitionName, completionHandler: completionHandler);
  }
  
  func replaceDocumentWithPartition(_ partitionName: String, documentId: String, document: MSDictionaryDocument, writeOptions: MSWriteOptions, completionHandler: @escaping (_ document:MSDocumentWrapper) -> Void) {
    MSData.replace(withDocumentID: documentId, document: document, partition: partitionName, writeOptions: writeOptions, completionHandler: completionHandler)
  }
  
  func deleteDocumentWithPartition(_ partitionName: String, documentId: String) {
    MSData.delete(withDocumentID: documentId, partition: partitionName, completionHandler: { document in
      print("Data.delete document with id \(documentId) succeeded")
    })
  }
}
