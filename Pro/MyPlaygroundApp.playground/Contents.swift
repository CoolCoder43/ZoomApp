//import UIKit
//
//enum Command:String{
//    case C = "C"
//    case D = "D"
//    case add = "+"
//}
//
//

import CoreText
////func addAndMultiplyFunc(isMult:Bool)->(Int,Int)-> Int{
////    func addTwoNumbers(numA:Int, numB:Int)->Int{
////        return numA + numB
////    }
////    func multiplyTwoNumbers(numA:Int, numB:Int)->Int{
////        return numA * numB
////    }
////    return isMult ? multiplyTwoNumbers(numA:numB:) : addTwoNumbers(numA:numB:)
////}
////
////var funcionsAdd = addAndMultiplyFunc(isMult: false)
////var funcionsMul = addAndMultiplyFunc(isMult: true)
//func calculateSum()->Int{
//    var sum = 0
//    func executeCommand(command:String, resultArr:inout [Int]){
//        switch command{
//        case Command.C.rawValue:
//            resultArr.removeLast()
//        case Command.D.rawValue:
//            resultArr.append(Array(resultArr.suffix(1)).reduce(2, *))
//        case Command.add.rawValue:
//            resultArr.append(Array(resultArr.suffix(2)).reduce(0, +))
//        default:
//            resultArr.append(Int(command)!)
//        }
//    }
//    var arrSource = ["8","9","+","D","6"]
//    var arrResult = [Int]()
//    for elem in arrSource{
//        executeCommand(command: elem, resultArr: &arrResult)
//    }
//    sum = arrResult.reduce(0, +)
//    return sum
//}
//
//
//
//print(calculateSum())
//
//
//

"(){}[]"

func compareWithCharacter(ch:String, and char:String)->Bool{
    switch(ch){
    case ")":
        return char == "("
    case "]":
        return char == "["

    case "}":
        return char == "{"
    default:return false
    }
    return false
}





func checkbOOL(charact:String,arrCharcter:[String], index:Int)->Bool{
    var startIndex = 0
    var reccuringIndex = 0
    for i in 0...arrCharcter.count{
        let isOpenAtIndexI = isopen(character: arrCharcter[i])
        
         if ( isClosed(character: arrCharcter[i]) && isClosed(character: arrCharcter[i+1])){
             if startIndex == 0{
                 startIndex = i - 1
             }else{
                 startIndex -= startIndex
             }
             if !compareWithCharacter(ch: arrCharcter[i], and: arrCharcter[reccuringIndex]){
                 return false
             }
        }else if (isOpenAtIndexI && isClosed(character: arrCharcter[i+1])){
            
        }

    }
    
}


func  isopen(character:String)->Bool {
    switch(character){
    case "{", "[", "(":
        return true
    default:return false
    }
}

func  isClosed(character:String)->Bool {
    switch(character){
    case "}", ")", "]":
        return true
    default:return false
    }
}
