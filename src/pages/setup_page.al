page 50021 "Service Request Setup"
{
    PageType = Card;
    SourceTable = "Service Request Setup";
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Service Request Setup';

    InsertAllowed = false;
    DeleteAllowed = false;
    // InsertAllowed = false; and DeleteAllowed = false; on a Dynamics 365 Business 
    //Central setup page prevents users from adding extra records or deleting the existing
    // configuration row.


    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Request Nos."; Rec."Request Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number series used for service requests.';
                }
            }
        }
    }
    // --- CALL THE SAFETY NET METHOD HERE ---
    trigger OnOpenPage()
    begin
        // Runs your table method to automatically create a blank record if the 
        //table is empty,
        // preventing a "Record does not exist" system crash when opening this screen.
        Rec.InsertIfNotExists();
    end;





}
