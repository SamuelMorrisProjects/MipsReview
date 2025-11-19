
#include <stdio.h>
// Greeting is implictly allocated in the data segment of the assembly code
static char greeting[3] = "yo";

int main() {
    char name[5] = "gurt";
    /* 
        Name automatically is allocated on the stack and the 
        memory is freed after the the function ends 
    */ 
    printf("%s %s\n",greeting, name);

    /*
        This memory is heap allocated and needs to be freed
        else it will persistent beyond program execution
        (since qtspim is a simulator we dont have to free it)
        This is dynamic memory allocation 
    */
    int *arr = malloc(sizeof(int)*5);
    // The pointer itself lives on the stack but NOT the memory its pointing to 

    free(arr);

    return 0;
}