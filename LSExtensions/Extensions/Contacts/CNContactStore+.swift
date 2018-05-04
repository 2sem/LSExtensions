//
//  CNContactStore.swift
//  LSExtensions
//
//  Created by 영준 이 on 2016. 3. 14..
//  Copyright © 2016년 leesam. All rights reserved.
//

import UIKit
import Contacts

extension CNContactStore {
    /**
        Finds a contact with given phone number and label
         - parameter phoneNumber: Phone number to find a contact with
         - parameter label: title for phone number, kind of phone number
         - parameter returns: a contact with given phone number and label
    */
    func findContact(phoneNumber number : String, label : String) throws -> CNContact?{
        let predicate = CNContact.predicateForContactsInContainer(withIdentifier: self.defaultContainerIdentifier());
        
        //CNContact.localizedString(forKey: CNLabelPhoneNumberMain);
        //CNContact.localizedString(forKey: CNLabelPhoneNumberiPhone);
        //CNContact.localizedString(forKey: CNLabelPhoneNumberMobile);
        
        //get contacts with properties specified
        var target : CNContact?;
        let contacts = try self.unifiedContacts(matching: predicate, keysToFetch: [CNContactFormatter.descriptorForRequiredKeys(for: .fullName), CNContactDepartmentNameKey as CNKeyDescriptor, CNContactJobTitleKey as CNKeyDescriptor, CNContactPhoneNumbersKey as CNKeyDescriptor, CNContactImageDataKey as CNKeyDescriptor]);
        
        print("load contacts. count[\(contacts.count)]");
        
        for contact in contacts{
            //Checks if the contact has mobile phone number
            let phoneMobile = contact.phoneNumbers.filter({ (phoneValue) -> Bool in
                //Finds with given label of phone number
                return phoneValue.label == label;
            }).first(where: { (phoneValue) -> Bool in
                //Removes '-' from phone number and compares
                let phoneNumber = phoneValue.value.stringValue
                    .replacingOccurrences(of: "-", with: "");
                return phoneNumber == number;
            });
            
            guard let _ = phoneMobile?.value else {
                continue;
            }
            
            /*print("############### contact[\(i)] ################")
            print("identifier[\(contact.identifier)]");
            print("\(CNContact.localizedString(forKey: CNContactGivenNameKey))[\(CNContactFormatter.string(from: contact, style: .fullName) ?? "")]");
            print("\(CNContact.localizedString(forKey: CNContactPhoneNumbersKey))[\(mobileNumber.stringValue)]");
            print("\(CNContact.localizedString(forKey: CNContactOrganizationNameKey))[\(contact.organizationName)]");
            print("\(CNContact.localizedString(forKey: CNContactDepartmentNameKey))[\(contact.departmentName)]");
            print("\(CNContact.localizedString(forKey: CNContactJobTitleKey))[\(contact.jobTitle)]");*/
            
            target = contact;
            
            break;
        }
        
        return target;
    }
}
