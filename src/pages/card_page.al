page 50005 "Service Request Card"
{
    PageType = Card;
    SourceTable = "service request";
    Caption = 'Service Request';


    UsageCategory = None;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("no."; Rec."no.")
                {
                    ApplicationArea = All;
                    AssistEdit = true; // Enables the '...' button for your automatic number series

                    trigger OnAssistEdit()
                    var
                        servicerequestsetup: Record "service request setup";
                        noseries: Codeunit "no. series";
                    begin
                        if Rec."no." = '' then begin
                            servicerequestsetup.Get();
                            servicerequestsetup.TestField("Request Nos.");
                            if noseries.LookupRelatedNoSeries(servicerequestsetup."Request Nos.", xRec."No. Series", Rec."No. Series") then begin
                                Rec."no." := noseries.GetNextNo(Rec."No. Series", WorkDate());
                            end;
                        end;
                    end;


                }

                field("customer no"; Rec."customer no.")
                {
                    ApplicationArea = All;
                }

                field(description; Rec.description)
                {
                    ApplicationArea = All;
                }

                field("request date"; Rec."request date")
                {
                    ApplicationArea = All;
                }

                field(priority; Rec.priority)
                {
                    ApplicationArea = All;
                    Style = Favorable;
                    StyleExpr = (Rec.priority = Rec.priority::high);


                }

                field(status; Rec.status)
                {
                    ApplicationArea = All;

                    Style = Ambiguous;
                    StyleExpr = (Rec.Status = Rec.Status::completed);

                }
            }
            part(Lines; "service request line page")
            {
                Caption = 'Lines test page';
                ApplicationArea = All;

                SubPageLink = "document_no" = field("no.");
            }
        }
        area(FactBoxes)
        {
            part(RequestSummary; "service request factbox")
            {
                ApplicationArea = All;

                // Links the sidebar record to the active record open on screen
                SubPageLink = "no." = field("no.");
            }
        }
    }

    actions
    {
        area(Processing)

        {
            group(Approval)
            {
                action(SetInProgress)
                {
                    Caption = 'release request';
                    ToolTip = 'changes the status of the request';
                    ApplicationArea = All;
                    Image = ReleaseDoc;
                    Promoted = True;
                    PromotedCategory = Process;
                    PromotedOnly = True;


                    trigger OnAction()
                    begin
                        Rec.status := Rec.status::"In_Progress";
                        Rec.Modify(True);
                        Message('status has been modified');
                    end;
                }
                action(reopen)
                {
                    Caption = 'reopen';
                    ApplicationArea = All;
                    ToolTip = 'reopen the document to make changes';
                    Image = ReOpen;
                    Promoted = True;
                    PromotedCategory = Process;
                    PromotedOnly = True;

                    trigger OnAction()
                    begin
                        Rec.priority := Rec.priority::high;
                        Message('priorities should be high')
                    end;
                }
                action(SendEmail)
                {
                    ApplicationArea = All;
                    Caption = 'Send Confirmation';
                    Image = Email;
                    Promoted = True;
                    PromotedCategory = Process;
                    PromotedOnly = True;


                    trigger OnAction()
                    begin

                        Message('Email sent to customer %1', Rec."customer no.");
                    end;
                }




                action(CompleteRequest)
                {
                    ApplicationArea = All;
                    Caption = 'Request Completed';
                    ToolTip = 'Validates and completes the service request.';

                    Image = Completed;
                    Promoted = True; // uers  dont need  to hunt dropdown menu
                    PromotedCategory = Process; // process tells the system to align with standard processing actions
                    PromotedOnly = True; // keeps your action bar clean by hiding from secondary menu
                    trigger OnAction()
                    var
                        SR_mgmt: Codeunit "service request mgmt codeunit";
                    begin
                        SR_mgmt.Run(Rec);
                        Message('service request has been completed successfully')
                    end;

                }
                action(PrintRequest)
                {
                    ApplicationArea = All;
                    Caption = 'Print Service Request';
                    ToolTip = 'Generates a PDF layout printout of this specific service request.';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        SRHeader: Record "service request";
                    begin
                        SRHeader.Reset();
                        // Filters the report engine to ONLY print the active record visible on screen
                        SRHeader.SetRange("no.", Rec."no.");

                        // Runs report 50000 modally
                        Report.RunModal(Report::"Service Request Report", true, false, SRHeader);
                    end;

                }
            }
        }
    }
}

//SRHeader.Reset();: This clears out any old filters or data left over in our temporary variable to ensure 
//a fresh search.SRHeader.SetRange("no.", Rec."no.");: This says: "Look at the table, find the column named 
//"no.", and filter it so it only matches the exact record (Rec."no.") currently open on the user's screen.
//"Why this is critical: Without this line, clicking print would process every single service request in your 
//entire database into one massive PDF. This keeps it down to just the single document on screen.
// Report.RunModal(...): This is a built-in Business Central command that pops up the report screen on top 
//of the page. The word "Modal" means it locks the screen behind it so the user must either finish printing 
//or cancel before going back to editing.
// Report::"Service Request Report": This tells the system exactly which report layout object to launch 
//(your report 50000).true: This tells the system to show the request page option window (the popup with your 
//"Hide Internal Details" checkbox toggle). If you set this to false, it would bypass your options screen
// completely.false: This tells the engine not to look for system printer settings, but rather use the
// default screen preview options.SRHeader: This passes the filtered record we set up in Step 2 directly 
//into the report engine.