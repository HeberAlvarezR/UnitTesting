import UIKit
import PlaygroundSupport

ContactManagerTest.defaultTestSuite.run()

var contactManager = ContactManager()
// Assigns the read data to variable "contactList"
let contactList = contactManager.readData(fileName: "contacts", type: "json")
var contactListArray = contactList.split(separator: "{")
var filtteredList = contactManager.removeDuplicates(array: contactListArray)
var data = contactManager.getContactData(list: filtteredList)
print(contactManager.getWholeName(data: data))
let contactListFilteredByAge = contactManager.filterByAge(data: data)


