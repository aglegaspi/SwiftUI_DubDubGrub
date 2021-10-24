//
//  ProfileViewModel.swift
//  SwiftUI_DubDubGrub
//
//  Created by Alex 6.1 on 9/27/21.
//

import CloudKit

enum ProfileContext { case create, update }

final class ProfileViewModel: ObservableObject {
    
    @Published var firstName    = ""
    @Published var lastName     = ""
    @Published var companyName  = ""
    @Published var bio          = ""
    @Published var avatar       = PlaceholderImage.avatar
    @Published var isShowingPhotoPicker = false
    @Published var isLoading    = false
    @Published var alertItem: AlertItem?
    
    private var existingProfileRecord: CKRecord? {
        didSet { profileContext = .update }
    }
    var profileContext: ProfileContext = .create
    
    // MARK: - Is Valid Profile
    func isValidProfile() -> Bool {
        
        guard !firstName.isEmpty,
              !lastName.isEmpty,
              !companyName.isEmpty,
              avatar != PlaceholderImage.avatar,
              bio.count <= 100 else { return false }
        
        return true
    } // isValidProfile
    
    // MARK: - Create Profile
    func createProfile() {
        guard isValidProfile() else {
            alertItem = AlertContext.invalidProfile
            return
        }
        
        let profileRecord = createProfileRecord()
        
        guard let userRecord = CloudKitManager.shared.userRecord else {
            alertItem = AlertContext.noUserRecord
            return
        }
        
        // Create reference on UserRecord to the DDGProfile we created
        userRecord["userProfile"] = CKRecord.Reference(recordID: profileRecord.recordID, action: .none)
        
        showLoadingView()
        
        CloudKitManager.shared.batchSave(records: [userRecord, profileRecord]) { result in
            DispatchQueue.main.async { [self] in
                hideLoadingView()
                
                switch result {
                case .success(let records):
                    existingProfileRecord = records.first(where: { $0.recordType == RecordType.profile})
                    CloudKitManager.shared.profileRecordID = records.first!.recordID
                    alertItem = AlertContext.createProfileSuccess
                    break
                case .failure(_):
                    alertItem = AlertContext.createProfileFailure
                    break
                } //switch
            }
            
        }//CloundKitManager
    } // createProfile
    
    // MARK: - Get Profile
    func getProfile() {
        
        guard let userRecord = CloudKitManager.shared.userRecord else {
            alertItem = AlertContext.noUserRecord
            return
        }
        
        // grab the reference from user record
        guard let profileReference = userRecord["userProfile"] as? CKRecord.Reference else { return }
        
        // get recordID of our profile record
        let profileRecordID = profileReference.recordID
        
        showLoadingView()
        
        CloudKitManager.shared.fetchRecord(with: profileRecordID) { result in
            DispatchQueue.main.async { [self] in
                
                hideLoadingView()
                switch result {
                case .success(let record):
                    existingProfileRecord = record
                    
                    let profile = DDGProfile(record: record)
                    firstName = profile.firstName
                    lastName = profile.lastName
                    companyName = profile.companyName
                    bio = profile.bio
                    avatar = profile.convertAvatarImage()
                case .failure(_):
                    alertItem = AlertContext.unableToGetProfile
                    break
                }
                
                } //DispatchQueue
        } // CloudKitManager
    } // getProfile
    
    func updateProfile() {
        guard isValidProfile() else {
            alertItem = AlertContext.invalidProfile
            return
        }
        
        guard let profileRecord = existingProfileRecord else {
            alertItem = AlertContext.unableToGetProfile
            return
        }
        
        profileRecord[DDGProfile.kFirstName] = firstName
        profileRecord[DDGProfile.kLastName] = lastName
        profileRecord[DDGProfile.kCompanyName] = companyName
        profileRecord[DDGProfile.kBio] = bio
        profileRecord[DDGProfile.kAvatar] = avatar.convertToCKAsset()
        
        showLoadingView()
        CloudKitManager.shared.save(record: profileRecord) { result in
            DispatchQueue.main.async { [self] in
                hideLoadingView()
                
                switch result {
                case .success(_):
                    alertItem = AlertContext.updateProfileSuccess
                case .failure(_):
                    alertItem = AlertContext.updateProfileFailure
                }
            }
            
        }
    }
    
    private func createProfileRecord() -> CKRecord {
        // Create our CKRecord from the profile view
        let profileRecord = CKRecord(recordType: RecordType.profile)
        existingProfileRecord = profileRecord
        profileRecord[DDGProfile.kFirstName] = firstName
        profileRecord[DDGProfile.kLastName] = lastName
        profileRecord[DDGProfile.kCompanyName] = companyName
        profileRecord[DDGProfile.kBio] = bio
        profileRecord[DDGProfile.kAvatar] = avatar.convertToCKAsset()
        
        return profileRecord
    } // createProfileRecord
    
    private func showLoadingView() { isLoading = true }
    private func hideLoadingView() { isLoading = false }
} // ProfileViewModel

