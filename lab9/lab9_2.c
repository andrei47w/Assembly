#include <stdio.h>

int negate(int a);

int main()
{
    char str[100];

    // read the string
    printf("Give string = ");
    scanf("%s", &str);

    int new_str[100];
    int i = 0;
    int pos = 0;
    while(str[i]){
        if(str[i] != ','){
            if(str[i] == '-'){
                i++;
                str[i-1] = ' ';
                new_str[pos++] = negate(atoi(str));
            }
            else new_str[pos++] = atoi(str);

            int temp_nr = new_str[pos-1];
            while (temp_nr != 0) {
                temp_nr /= 10;
                i++;
            }
            for(int j=0; j<=i; j++) str[j] = ' ';
        }
        
        i++;
    }
    
    return 0;
}