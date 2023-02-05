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
    var textOnLabel = AppStrings.INITIAL_VALUE

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
        if self.textOnLabel.count > 1 && self.textOnLabel.starts(with: AppStrings.ZERO) {
            self.textOnLabel.remove(at: self.textOnLabel.startIndex)
        }
        if self.textOnLabel.starts(with: AppStrings.MULTPLE_FRONT_END) ||
            self.textOnLabel.starts(with: AppStrings.PLUS) ||
            self.textOnLabel.starts(with: AppStrings.DIVIDE_FRONT_END) {
            self.textOnLabel = AppStrings.INITIAL_VALUE
        }
        delegate?.showUpdatedTextOnScreen(textOnLabel: self.textOnLabel)
    }

    /**
     Method that will check the last element is a operation or not.
     */
    func isLastElementSymbol() -> Bool {
        guard let lastElement = self.textOnLabel.last else {
            return false
        }
        if String(lastElement) == AppStrings.PLUS ||
            String(lastElement) == AppStrings.MINUS ||
            String(lastElement) == AppStrings.MULTPLE_FRONT_END ||
            String(lastElement) == AppStrings.DIVIDE_FRONT_END {
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
        guard let lastElement = self.textOnLabel.last else {
            return
        }
        if String(lastElement) == AppStrings.DOT {
            isDecimal = false
            isDecimalSecondaryCheck = false
        }
    }

    /**
     Method that will remove last element iff last element is a symbol.
     */
    func checkLastElement() {
        guard let lastElement = self.textOnLabel.last else {
            return
        }
        if String(lastElement) == AppStrings.PLUS ||
            String(lastElement) == AppStrings.MINUS ||
            String(lastElement) == AppStrings.MULTPLE_FRONT_END ||
            String(lastElement) == AppStrings.DIVIDE_FRONT_END ||
            String(lastElement) == AppStrings.DOT {
            _ = self.textOnLabel.popLast()
        }
    }

    /**
     A method that will calculate the result of an expression.
     */
    func calculateResult() -> Double {
        let mappedString = String(self.textOnLabel.map{
            if ($0 == Character(AppStrings.MULTPLE_FRONT_END)) {
                return Character(AppStrings.MULTIPLE_BACK_END)
            } else if ($0 == Character(AppStrings.DIVIDE_FRONT_END)) {
                return Character(AppStrings.DIVIDE_BACK_END)
          } else {
            return $0
          }
        })
        let expression = NSExpression(format: mappedString)
        let result = expression.expressionValue(with: nil, context: nil) as? Double
        guard let result = result else {
          return 0.0
        }
        return result
      }
}

//MARK: Extension

extension Model: calculatorBackendProtocol {
    func btnZeroClicked() {
        setDecimalSecondaryCheckStatus()
        self.textOnLabel += AppStrings.ZERO
        updateLabel()
    }
    
    func btnOneClicked() {
        setDecimalSecondaryCheckStatus()
        self.textOnLabel += AppStrings.ONE
        updateLabel()
    }
    
    func btnTwoClicked() {
        setDecimalSecondaryCheckStatus()
        self.textOnLabel += AppStrings.TWO
        updateLabel()
    }
    
    func btnThreeClicked() {
        setDecimalSecondaryCheckStatus()
        self.textOnLabel += AppStrings.THREE
        updateLabel()
    }
    
    func btnFourClicked() {
        setDecimalSecondaryCheckStatus()
        self.textOnLabel += AppStrings.FOUR
        updateLabel()
    }
    
    func btnFiveClicked() {
        setDecimalSecondaryCheckStatus()
        self.textOnLabel += AppStrings.FIVE
        updateLabel()
    }
    
    func btnSixClicked() {
        setDecimalSecondaryCheckStatus()
        self.textOnLabel += AppStrings.SIX
        updateLabel()
    }
    
    func btnSevenClicked() {
        setDecimalSecondaryCheckStatus()
        self.textOnLabel += AppStrings.SEVEN
        updateLabel()
    }
    
    func btnEightClicked() {
        setDecimalSecondaryCheckStatus()
        self.textOnLabel += AppStrings.EIGHT
        updateLabel()
    }
    
    func btnNineClicked() {
        setDecimalSecondaryCheckStatus()
        self.textOnLabel += AppStrings.NINE
        updateLabel()
    }
    
    func btnPlusClicked() {
        setDecimalCheckVariablesWhenOperationsClicked()
        checkLastElement()
        self.textOnLabel += AppStrings.PLUS
        updateLabel()
        isDecimal = false
    }
    
    func btnMinusClicked() {
        setDecimalCheckVariablesWhenOperationsClicked()
        isDecimal = false
        // Explicitely handle the 0.- condition
        if self.textOnLabel == AppStrings.ZERO + AppStrings.DOT {
            self.textOnLabel = AppStrings.ZERO
            updateLabel()
            return
        }
        checkLastElement()
        self.textOnLabel += AppStrings.MINUS
        updateLabel()
    }
    
    func btnMultiplyClicked() {
        setDecimalCheckVariablesWhenOperationsClicked()
        checkLastElement()
        self.textOnLabel += AppStrings.MULTPLE_FRONT_END
        updateLabel()
        isDecimal = false
    }
    
    func btnDivideClicked() {
        setDecimalCheckVariablesWhenOperationsClicked()
        checkLastElement()
        self.textOnLabel += AppStrings.DIVIDE_FRONT_END
        updateLabel()
        isDecimal = false
    }
    
    func btnDotClicked() {
        if isDecimal || isDecimalSecondaryCheck {
            return
        }
        checkLastElement()
        self.textOnLabel == AppStrings.ZERO ? (self.textOnLabel += AppStrings.ZERO + AppStrings.DOT) : (self.textOnLabel += AppStrings.DOT)
        updateLabel()
        isDecimal = true
        isDecimalSecondaryCheck = true
    }
    
    func btnEqualToClicked() {
        if self.textOnLabel == AppStrings.ZERO {
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
        if self.textOnLabel == AppStrings.ZERO {
            return
        } else if self.textOnLabel.count == 1 {
            self.textOnLabel = AppStrings.ZERO
            updateLabel()
            return
        } else {
            _ = self.textOnLabel.popLast()
            updateLabel()
        }
    }
    
    func btnACClicked() {
        self.textOnLabel = AppStrings.ZERO
        updateLabel()
        isDecimal = false
        isDecimalSecondaryCheck = false
    }
}
