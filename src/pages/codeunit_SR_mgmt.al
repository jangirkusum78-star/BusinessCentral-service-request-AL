Codeunit 50030 "service request mgmt codeunit"
{
    TableNo = "service request";
    // creating the procedure
    procedure releasedocument(var service_header: Record "service request")

    var
        serviceline: Record "service request line";
    begin
        //RULE 1: If it is already completed, stop immediately to save 
        //system memory
        if service_header.priority = service_header.priority::high then
            exit;

        // // RULE 2: Standout Validation - Prevent submitting data without a customer assignment
        if service_header."customer no." = '' then
            Error('Cannot release request %1 because no Customer No. has been assigned.', Service_Header."no.");           // Rule 3: Standout Validation - Check if child lines exist

        //
        serviceline.SetRange("document_no", service_header."no.");
        if ServiceLine.IsEmpty() then
            Error('You cannot complete an empty request. Please add at least one line item grid below.');

        // RULE 4: Process the business workflow step safely  

        service_header.status := service_header.status::completed;
        // modifying
        service_header.Modify(true);

    end;

    // Impact of codeunit 
    //Validating Data: The code prevents users from completing 
    //or submitting an empty Service Request document.
    //Protecting Database Integrity: It searches for child items (lines) attached to 
    //the main request header.
    //Enforcing Rules: If it finds no lines, it blocks the user with an error message
    // saying they cannot complete an empty request.









}