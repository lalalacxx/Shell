#!/usr/bin/awk -f

BEGIN{
    FS=":";
    excellent=0;
    good=0;
    middle=0;
    bad=0;
    }

    {
        if($2 > 85)
        {
            excellent++;
        }
        else if($2 > 75)
        {
            good++;
        }
        else if($2 > 60)
        {
            middle++;
        }
        else
        {
            bad++;
        }
    }
    END{
        printf("%d\n",excellent);
        printf("%d\n",good);
        printf("%d\n",middle);
        printf("%d\n",bad);
        }
