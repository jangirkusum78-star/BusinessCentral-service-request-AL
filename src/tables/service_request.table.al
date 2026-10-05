table 50001 "service request"
{
    Caption = 'Service request';
    DataClassification = CustomerContent;

    fields
    {
        field(100; "no."; Code[30])
        {
            Caption = 'no.';
            DataClassification = CustomerContent;

        }
        field(101; "customer no."; Code[10])
        {
            Caption = 'customer no.';
            DataClassification = CustomerContent;
        }
        field(102; description; Text[100])
        {
            Caption = 'description';
            DataClassification = CustomerContent;
        }
        field(103; "request date"; date)
        {
            Caption = 'request date';
            DataClassification = CustomerContent;
        }
        field(104; priority; Enum "service request ")
        {
            Caption = 'priority list';
            DataClassification = CustomerContent;
        }
        field(106; custvalue; code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(105; status; Enum "service request enum status")
        {
            Caption = 'status list';
            DataClassification = CustomerContent;


            trigger OnValidate()
            //var
            // myInt: Integer;
            begin
                Clear(storevalue);
                if status = status::completed then
                    rec.custvalue := rec."customer no.";
                // Message('status has changed to normal');
            end;


        }
        field(107; "No. Series"; Code[30])
        // 2. Added tracking field for Business Foundation engine

        {
            DataClassification = CustomerContent;
            Editable = False;
        }


    }

    keys
    {
        key(Pk; "no.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        storevalue: code[100];

    trigger OnInsert()
    var
        servicerequestsetup: Record "service request setup";
        noseries: Codeunit "no. series";
    begin
        if "no." = '' then begin
            servicerequestsetup.Get();
            servicerequestsetup.TestField("Request Nos.");
            "no." := NoSeries.GetNextNo(
               servicerequestsetup."Request Nos.", WorkDate()
            );
            "No. Series" := servicerequestsetup."Request Nos.";
        end;
        if "Request Date" = 0D then
            "Request Date" := WorkDate();

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}