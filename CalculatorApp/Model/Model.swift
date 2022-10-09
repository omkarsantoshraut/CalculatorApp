//MARK: Imports

import Foundation

//MARK: Protocol (calculatorProtocol)

/**
 Protocol that will help to show updated expression on the screen.
 */
protocol calculatorProtocol {
    func showUpdatedTextOnScreen(textOnLabel:String)
}

//MARK: Model class

class Model: NSObject {

    /**
     The delegate of calculatorBackendProtocol which helps to call methods of View class from this class.
     */
    var delegate: calculatorProtocol?
    
    // variable that store the calculation (expression) which helps to show it on screen.
    var textOnLabel = "0"

    // Variable that helps to find number is decimal or not
    var isDecimal: Bool = false
    var isDecimalSecondaryCheck: Bool = false

    // init method
    override init() {

    }

    /**
     Method that will show updated expression on the screen.
     */
    func updateLabel() {
        if self.textOnLabel.count > 1 && self.textOnLabel.starts(with: "0") {
            self.textOnLabel.remove(at: self.textOnLabel.startIndex)
        }
        if self.textOnLabel.starts(with: "x") || self.textOnLabel.starts(with: "+") || self.textOnLabel.starts(with: "÷") {
            self.textOnLabel = "0"
        }
        delegate?.showUpdatedTextOnScreen(textOnLabel: self.textOnLabel)
    }

    /**
     Method that will check the last element is a operation or not.
     */
    func isLastElementSymbol() -> Bool {
        if self.textOnLabel.last == "+" ||
            self.textOnLabel.last == "-" ||
            self.textOnLabel.last == "x" ||
            self.textOnLabel.last == "÷" {
            return true
        }
        return false
    }

    /**
     Method that will set state of isDecimalSecondaryCheck
     */
    func setDecimalSecondaryCheckStatus() {
        if isLastElementSymbol() && isDecimalSecondaryCheck {
            isDecimalSecondaryCheck = false
        }
    }

    /**
     Method that will set state of variables if click is on operation buttons.
     */
    func setDecimalCheckVariablesWhenOperationsClicked() {
        if self.textOnLabel.last == "." {
            isDecimal = false
            isDecimalSecondaryCheck = false
        }
    }

    /**
     Method that will remove last element iff last element is a symbol.
     */
    func checkLastElement() {
        if self.textOnLabel.last == "+" ||
            self.textOnLabel.last == "-" ||
            self.textOnLabel.last == "x" ||
            self.textOnLabel.last == "÷" ||
            self.textOnLabel.last == "." {
            _ = self.textOnLabel.popLast()
        }
    }

    /**
     A recursive method that will calculate the result of an expression.
     */
    func calculateResult() -> Float {
        var op: String = ""
        var num = ""
        var isMinus: Bool = false
        while true {
            print("##", self.textOnLabel)
            if self.textOnLabel.count == 0 {
                break
            }
            if self.textOnLabel.first == "+" ||
                self.textOnLabel.first == "-" ||
                self.textOnLabel.first == "x" ||
                self.textOnLabel.first == "÷" {
                op = String(self.textOnLabel.first!)
                self.textOnLabel = String(self.textOnLabel.dropFirst())
                if op == "-" && num == "" {
                    isMinus = true
                    continue
                }
                break
            } else {
                num += String(self.textOnLabel.first!)
                self.textOnLabel = String(self.textOnLabel.dropFirst())
            }
        }
        if op == "+" {
            if isMinus {
                return -Float(num)! + calculateResult()
            }
            return Float(num)! + calculateResult()
        } else if op == "-" {
            if isMinus {
                return -Float(num)! - calculateResult()
            }
            return Float(num)! - calculateResult()
        } else if op == "x" {
            if isMinus {
                return -Float(num)! * calculateResult()
            }
            return Float(num)! * calculateResult()
        } else if op == "÷" {
            if isMinus {
                return -Float(num)! / calculateResult()
            }
            return Float(num)! / calculateResult()
        } else {
            if isMinus {
                return -Float(num)!
            }
            return Float(num)!
        }
    }
}

//MARK: Extension

extension Model: calculatorBackendProtocol {
    func btnZeroClicked() {
        setDecimalSecondaryCheckStatus()
        self.textOnLabel += "0"
        updateLabel()
    }
    
    func btnOneClicked() {
        setDecimalSecondaryCheckStatus()
        self.textOnLabel += "1"
        updateLabel()
    }
    
    func btnTwoClicked() {
        setDecimalSecondaryCheckStatus()
        self.textOnLabel += "2"
        updateLabel()
    }
    
    func btnThreeClicked() {
        setDecimalSecondaryCheckStatus()
        self.textOnLabel += "3"
        updateLabel()
    }
    
    func btnFourClicked() {
        setDecimalSecondaryCheckStatus()
        self.textOnLabel += "4"
        updateLabel()
    }
    
    func btnFiveClicked() {
        setDecimalSecondaryCheckStatus()
        self.textOnLabel += "5"
        updateLabel()
    }
    
    func btnSixClicked() {
        setDecimalSecondaryCheckStatus()
        self.textOnLabel += "6"
        updateLabel()
    }
    
    func btnSevenClicked() {
        setDecimalSecondaryCheckStatus()
        self.textOnLabel += "7"
        updateLabel()
    }
    
    func btnEightClicked() {
        setDecimalSecondaryCheckStatus()
        self.textOnLabel += "8"
        updateLabel()
    }
    
    func btnNineClicked() {
        setDecimalSecondaryCheckStatus()
        self.textOnLabel += "9"
        updateLabel()
    }
    
    func btnPlusClicked() {
        setDecimalCheckVariablesWhenOperationsClicked()
        checkLastElement()
        self.textOnLabel += "+"
        updateLabel()
        isDecimal = false
    }
    
    func btnMinusClicked() {
        setDecimalCheckVariablesWhenOperationsClicked()
        isDecimal = false
        // Explicitely handle the 0.- condition
        if self.textOnLabel == "0." {
            self.textOnLabel = "0"
            updateLabel()
            return
        }
        checkLastElement()
        self.textOnLabel += "-"
        updateLabel()
    }
    
    func btnMultiplyClicked() {
        setDecimalCheckVariablesWhenOperationsClicked()
        checkLastElement()
        self.textOnLabel += "x"
        updateLabel()
        isDecimal = false
    }
    
    func btnDivideClicked() {
        setDecimalCheckVariablesWhenOperationsClicked()
        checkLastElement()
        self.textOnLabel += "÷"
        updateLabel()
        isDecimal = false
    }
    
    func btnDotClicked() {
        if isDecimal || isDecimalSecondaryCheck {
            return
        }
        checkLastElement()
        self.textOnLabel == "0" ? (self.textOnLabel += "0.") : (self.textOnLabel += ".")
        updateLabel()
        isDecimal = true
        isDecimalSecondaryCheck = true
    }
    
    func btnEqualToClicked() {
        if self.textOnLabel == "0" {
            return
        }
        checkLastElement()
        self.textOnLabel = String(calculateResult())
        updateLabel()
        isDecimal = true
        isDecimalSecondaryCheck = true
    }
    
    func btnPercentageClicked() {
        self.textOnLabel = String(calculateResult()/100)
        updateLabel()
        isDecimal = true
        isDecimalSecondaryCheck = true
    }
    
    func btnDELClicked() {
        setDecimalCheckVariablesWhenOperationsClicked()
        if self.textOnLabel == "0" {
            return
        } else if self.textOnLabel.count == 1 {
            self.textOnLabel = "0"
            updateLabel()
            return
        } else {
            _ = self.textOnLabel.popLast()
            updateLabel()
        }
    }
    
    func btnACClicked() {
        self.textOnLabel = "0"
        updateLabel()
        isDecimal = false
        isDecimalSecondaryCheck = false
    }
}
