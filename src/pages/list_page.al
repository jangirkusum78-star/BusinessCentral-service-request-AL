page 50004 "service request page"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Service Request Card";
    SourceTable = "service request";
    Caption = 'Service Requests';
    Editable = False;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("no"; Rec."no.")
                {
                    ApplicationArea = All;
                }
                field("customer no."; Rec."customer no.")
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
                //Style = Favorable; // Green color

                {
                    Style = Favorable; // Green color        
                    StyleExpr = (Rec.priority = Rec.priority::high);



                    ApplicationArea = All;
                }
                field(status; Rec.status)
                {
                    Style = Ambiguous; // Green color
                    StyleExpr = (Rec.status = Rec.status::Completed);


                    ApplicationArea = All;
                }


            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}