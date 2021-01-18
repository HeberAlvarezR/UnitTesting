import Foundation
import UIKit
import PlaygroundSupport

public class ContactManager {
    public init() {}
    public func readData(fileName: String, type: String) -> String{
        // MARK: - Accessing data
        // Get the file path for the file "contacts.json" in the playground bundle
        let filePath = Bundle.main.path(forResource: fileName, ofType: type)
        var resultData: String = ""
        // Get the contentData
        let contentData = FileManager.default.contents(atPath: filePath!)

        // Get the string
        let content = String(data:contentData!, encoding:String.Encoding.utf8)

//        print("filepath: \(filePath!)")

        if let contactsList = content {
            print("content: \n\(contactsList)")
            resultData = contactsList
        }
        return resultData.replacingOccurrences(of: "\n]", with: "").replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: "}", with: "") + ",  {"
    }
    public func removeDuplicates(array:[String.SubSequence])-> [String]{
        var newArray = Set(array)
        var list = [String]()
        for _ in 0..<(Set(array)).count{
            guard let element = newArray.first else { return ["Error al guardar los elementos"]}
            list.append(String(element))
//            print("\nelement \(i)\n\n",list)
            newArray.removeFirst()
        }
        return list
    }
    public func getContactData(list: [String]) -> [[String]] {
        var nombre = [String()]
        var apellido = [String()]
        var correo = [String()]
        var edad = [String()]
        
        for i in 0..<list.count{
            let contactInfo = String(list[i])//.split(separator: ",")[0]//.split(separator: ":")
            var elements = contactInfo.split(separator: ",")
            
            if elements.count != 4 {
                elements.removeLast()
            }
            if elements.count == 4 {
                nombre.append( String(elements[0].split(separator: ":")[1]).replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: " ", with: ""))
                apellido.append( String(elements[1].split(separator: ":")[1]).replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: " ", with: ""))
                correo.append(String(elements[2].split(separator: ":")[1]).replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: " ", with: ""))
                edad.append(String(elements[3].split(separator: ":")[1]).replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "\n}", with: ""))
            }
        }
        return [nombre,apellido,correo,edad]
    }
    
    public func getWholeName(data:[[String]])->[String]{
        var wholeNameData = [String]()
        for i in 0..<data[0].count{
            wholeNameData.append(data[0][i]+" "+data[1][i])
//            print(data[0][i]+" "+data[1][i])
        }
        return wholeNameData
    }
    public func filterByAge(data:[[String]])->[String]{
        var filteredData = [String]()
        var nombre = data[0]
        var apellido = data[1]
        var correo = data[2]
        var edad = data[3]
        nombre.removeFirst()
        apellido.removeFirst()
        correo.removeFirst()
        edad.removeFirst()
        let age = edad.map{ Int($0)!}

        for i in 0..<age.count{
            if age[i] > 18{
                print([nombre[i],apellido[i],correo[i],age[i]])
                filteredData.append(nombre[i]+" "+apellido[i]+"\n"+correo[i]+"\n"+String(age[i]))
            }
        }
        return(filteredData)
    }
}
