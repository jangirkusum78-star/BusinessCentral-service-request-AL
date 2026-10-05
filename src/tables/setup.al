table 50020 "Service Request Setup"
{
    Caption = 'Service Request Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[30])
        {
            Caption = 'Primary Key';
            DataClassification = CustomerContent;
        }

        field(2; "Request Nos."; Code[30])
        {
            Caption = 'Request Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
    // 3. Added standard professional initialization helper method
    procedure InsertIfNotExists()
    begin
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert(true);
        end;
    end;





}
