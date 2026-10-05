page 50022 "service request line page"
{
    PageType = ListPart;
    Caption = 'line part';
    SourceTable = "service request line";
    AutoSplitKey = True;
    MultipleNewLines = True;
    DelayedInsert = True;

    layout
    {
        area(Content)
        {
            repeater(lines)
            {
                field("document_no"; Rec."document_no")
                {
                    ApplicationArea = All;
                }
                field("line_no"; Rec."line_no")
                {
                    ApplicationArea = All;
                }

                field("item_no"; Rec."item_no")
                {
                    ApplicationArea = All;
                }

                field(description; Rec.description)
                {
                    ApplicationArea = All;
                }

                field(quantity; Rec.quantity)
                {
                    ApplicationArea = All;
                }

                field("unit_price"; Rec."unit_price")
                {
                    ApplicationArea = All;
                }

                field("line_amount"; Rec."line_amount")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}


//actions
// {
// area(Processing)
//{
// action(ActionName)
// {

// trigger OnAction()
// begin

//end;
//}
//}
// }

//var
//myInt: Integer;
//}