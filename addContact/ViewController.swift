//
//  ViewController.swift
//  addContact
//
//  Created by KF on 1/22/19.
//  Copyright © 2019 KF. All rights reserved.
//

import UIKit
// import AddressBook
import Contacts
import ContactsUI

class ViewController: UIViewController, CNContactPickerDelegate {

    @IBAction func addButton(_ sender: Any) {
        let newContact = CNMutableContact()
        newContact.givenName = "Your Name"
        newContact.jobTitle = "CTO xyz Company"
        
        let workEmail = CNLabeledValue(label:CNLabelWork, value:"demoxyz@gmail.com" as NSString)
        newContact.emailAddresses = [workEmail]
        newContact.phoneNumbers = [CNLabeledValue(
            label:CNLabelPhoneNumberiPhone,
            value:CNPhoneNumber(stringValue:"0123456789"))]
        do {
            let saveRequest = CNSaveRequest()
            saveRequest.add(newContact, toContainerWithIdentifier: nil)
            try AppDelegate.getAppDelegate().contactStore.execute(saveRequest)
        } catch {
            AppDelegate.getAppDelegate().showMessage("Unable to save the new contact.")
        }
    }
    
    @IBAction func newButton (_ sender: Any) {
        let cnPicker = CNContactPickerViewController()
        cnPicker.delegate = self
        cnPicker.displayedPropertyKeys = [CNContactGivenNameKey, CNContactEmailAddressesKey]
        self.present(cnPicker, animated: true, completion: nil)
       // print()
        // bugFix
    }
  
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contacts: [CNContact]) {
        contacts.forEach { contact in
            let name = contact.givenName
            let surname = contact.familyName
            print("name = \(name)")
            print("surname = \(surname)")
            for number in contact.phoneNumbers {
                let phoneNumber = number.value
                print("number is = \(phoneNumber)")
            }
        }
    }
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        print("Cancel Contact Picker")
    }

}

