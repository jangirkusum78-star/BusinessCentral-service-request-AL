page 50025 "service request factbox"
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "service request";
    Caption = 'request summary';


    layout
    {
        area(Content)
        {
            group(info)


            {
                ShowCaption = false;

                field("no."; Rec."no.")
                {
                    ApplicationArea = All;
                }
                field(priority; Rec.priority)
                {
                    ApplicationArea = All;
                }
                field(status; Rec.status)
                {
                    ApplicationArea = All;
                }



            }
        }
    }

    // actions
    // {
    //     area(Processing)
    //     {
    //         action(ActionName)
    //         {

    //             trigger OnAction()
    //             begin

    //             end;
    //         }
    //     }
    // }

    // var
    //     myInt: Integer;
}