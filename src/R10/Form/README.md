TODO

* FIX the problem of the duplcate helperSignin_M03_Submit
* Use border color as primary color for the form library(?), also for links
* FIx the view, so that the button is active at start R06
* Check search input field in dropdowns
* Fix fields in http://localhost:8002/#/r99
* Green errors in password fields (wrong translations)



## Validations

Validations are done 

    * R10.Form.Internal.Update.onChangeValue (only for few fields, calling "runOnlyExistingValidations")
    * "validateEntireForm" instead run "runAllValidations", used when the submit buttons is pressed.
    
    
## Logic of fromFieldStateValidationToComponentValidation  

* R10.Form.Internal.Converter.fromFieldStateValidationToComponentValidation  
    
type alias ValidationSpecs =
    { showAlsoPassedValidation : Bool
    , pretendIsNotValidatedIfValid : Bool
    , validation : List Validation
    , validationIcon : R10.FormTypes.ValidationIcon
    }


The main function for validations is R10.Form.Internal.Validation.validate


shouldValidationBeVisible