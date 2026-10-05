table 50011 "service request line"
{
    Caption = 'service request line';
    DataClassification = ToBeClassified;

    fields
    {
        field(201; "document_no"; code[50])
        {
            Caption = 'document no.';
            TableRelation = "Service Request"."no.";

        }
        field(202; description; Text[100])
        {
            Caption = 'details';

        }
        field(203; "line_no"; integer)
        {
            Caption = 'line no';
        }
        field(204; "item_no"; code[20])
        {
            Caption = 'item no';
            TableRelation = item."No.";
            trigger OnValidate()
            var
                item: Record item;
            begin
                if item.Get("item_no") then begin
                    description := item.description;
                    "unit_price" := item."Unit Price";
                end;
            end;
        }
        field(205; quantity; decimal)
        {
            Caption = 'quantity';
            DecimalPlaces = 0 : 5;
            trigger OnValidate()
            begin
                CalculateLineAmount();
            end;

        }
        field(206; "unit_price"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'unit price';
            trigger OnValidate()
            begin
                CalculateLineAmount();
            end;
        }
        field(207; "line_amount"; decimal)
        {
            Caption = 'line amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
    }


    keys
    {
        key(K1; "document_no", "line_no")
        {
            Clustered = true;
        }
    }
    local procedure CalculateLineAmount()
    begin
        "line_amount" := quantity * "unit_price";
    end;


}




//var
//myInt: Integer;

//trigger OnInsert()
//begin


//end;

//trigger OnModify()
//begin

//;

// trigger OnDelete()
// begin

// end;

//trigger OnRename()
//begin

//end;

