# Swiftz-Validation

A data structure that typically models form validations, and other scenarios where you want to aggregate all failures, rather than short-circuit if an error happens (for which Swiftx's Either is better suited).
A Validation may either be a Success(value), which contains a successful value, or a Failure(value), which contains an error.

## Example

```swift
    func isPasswordLongEnough(_ password:String) -> Validation<[String], String> {
        if password.characters.count < 8 {
            return Validation.Failure(["Password must have more than 8 characters."])
        } else {
            return Validation.Success(password)
        }
    }
    
    func isPasswordStrongEnough(_ password:String) -> Validation<[String], String> {
        if (password.range(of:"[\\W]", options: .regularExpression) != nil){
            return Validation.Success(password)
        } else {
            return Validation.Failure(["Password must contain a special character."])
        }
    }
    
    func isPasswordValid(password:String) -> Validation<[String], String> {    
        return isPasswordLongEnough(password)
            .sconcat(isPasswordStrongEnough(password))
    }
    
```
Valid value

```swift
   let result = isPasswordValid(password: "Ricardo$")

   /*
       ▿ Validation<Array<String>, String>
           - Success : "Ricardo$"
   */
```

Invalid value
```swift
    let result = isPasswordValid(password: "Richi")
    
    /* ▿ Validation<Array<String>, String>
           ▿ Failure : 2 elements
                - 0 : "Password must have more than 8 characters."
                - 1 : "Password must contain a special character."
    */

```
