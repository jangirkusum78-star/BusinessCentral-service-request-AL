enum 50003 "service request enum status"
{
    Extensible = true;
    value(0; open)
    {
        Caption = 'open';

    }
    value(1; In_progress)
    {
        Caption = 'In Progress';
    }
    value(2; completed)
    {
        Caption = 'completed';
    }

}