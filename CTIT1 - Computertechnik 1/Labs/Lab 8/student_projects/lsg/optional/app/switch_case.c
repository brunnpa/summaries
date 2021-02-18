extern void switch_case_example(void);

void switch_case_example(void)
{
    int test = 1;

    while (1) {
        switch (test) {
            case 0:
                test = 5;
                break;

            case 1:
                test = 4;
                break;

            case 2:
                test = 3;
                break;

            case 3:
                test = 0;
                break;

            case 4:
                test = 2;
                break;

            case 5:
                test = 8;
                break;

            case 6:
                test = 40;
                break;

            case 7:
                test = 6;
                break;

            case 8:
                test = 7;
                break;



            default:
                return;
        }
    }
}
