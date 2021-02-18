
    /*
    solange NAME der neuen Person grösser ist, als das nächste Element gehe zum nächsten Element
    */ 
    while(comparePersons(newPerson->content, current->next->content > 0){
        current = current->next;
    }
    /*
    Falls der NAME identisch ist, vergleiche den Vorname
    solange FIRSTNAME der neuen Person grösser ist, als das nächste Element gehe zum nächsten Element
    */
    if(comparePersons(newPerson->name, current->next->content->name) == 0){
        while(comparePersons(newPerson->firstname, current->next->content->firstname) > 0){
            current = current->next;
        }
    }
    /*
    Falls der FIRSTNAME identisch ist, vergleiche den Vorname
    solange AGE der neuen Person grösser ist, als das nächste Element gehe zum nächsten Element
    */
    if(comparePersons(newPerson->firstname, current->next->content->name) == 0){
        while((newPerson->age) > (current->next->content->age)){
            current = current->next;
        }
    }
    else if(comparePersons(newPerson, current->next->content) == 0) {
            printf("[FAILED]...The person is already in the list");
        }
    
    node_LE *new = malloc(sizeof(node_LE));
            if(new){
                new->content = newPerson;
                new->next = current->next;
                current->next = new;
                printf("[SUCCESS]...Person has been saved successfully\n");
                printf("\n");
            }
            else {
                printf("[FAILED]...You didn't get enough space...");
            }
