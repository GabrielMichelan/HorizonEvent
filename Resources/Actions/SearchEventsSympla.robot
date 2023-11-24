*** Settings ***
Documentation        Suíte das Keywords relacionadas com a suíte "Eventos.robot" - Site da Sympla. 

Resource             ../Base.robot

*** Keywords ***
Dado que estamos na página inicial da Sympla
    Go To                            url=${URLSYMPLA}
    Wait Until Element Is Visible    ${SYMPLASLOGAN}   


Quando é feito a pesquisa de eventos
    @{Eventos}           Create List
    Click Element                         ${EVENTSCATEGORY}   
    Wait Until Page Contains              text=Encontre eventos   
    Execute Javascript                    window.scroll(0, 400)
    ${elemento_existe}                    Run Keyword And Return Status      Element Should Be Visible    ${ACCEPTCOOKIESBUTTON}
    Sleep        3
    Run Keyword If                        "${elemento_existe}" == "True"     Click Button                 ${ACCEPTCOOKIESBUTTON}  
    Sleep    3
    Set Test Variable                     ${Eventos}
    Coletar eventos
    Go Back
    Wait Until Element Is Visible         ${LOCATORINITIALPAGE}
            
        
        
Coletar eventos
    FOR    ${counter}    IN RANGE    0        5
        @{CardsDeEventos}               Get WebElements                               ${LOCATOREVENTCARD}
        @{LocatorsListEventDate}        Get WebElements                               ${LOCATOREVENTDATE} 
        ${DataEvento}                   Get Text                                      ${LocatorsListEventDate[${counter}]} 
        @{LocatorsListEventImage}       Get WebElements                               ${LOCATOREVENTIMAGE} 
        ${ImagemEVento}          SeleniumLibrary.Get Element Attribute                ${LocatorsListEventImage[${counter}]}        src                        
        @{LocatorsListEventName}        Get WebElements                               ${LOCATOREVENTNAME}
        ${NomeEvento}                   Get Text                                      ${LocatorsListEventName[${counter}]}
        @{LocatorsListEventLocal}       Get WebElements                               ${LOCATOREVENTLOCAL}  
        ${LocalEvento}                  Get Text                                      ${LocatorsListEventLocal[${counter}]}                                                                 
        Click Element                                                                 ${CardsDeEventos[${counter}]}
        Wait Until Page Contains                                                      text=Ingressos            
        ${UrlEVento}                  Get Location
        Append To List                ${Eventos}                                      ${NomeEvento}  
        Append To List                ${Eventos}                                      ${DataEvento}
        Append To List                ${Eventos}                                      ${LocalEvento}
        Append To List                ${Eventos}                                      ${UrlEVento} 
        Append To List                ${Eventos}                                      ${ImagemEVento} 
        ${DifferentBuyPageElement}    Run Keyword And Return Status                   Element Should Be Visible                    ${DIFFERENTBUYPAGE} 
        Go Back

        IF   '${DifferentBuyPageElement}' == 'True'         
              Go Back
              Wait Until Element Is Visible                                             ${LOCATORFINDEVENTS}
        END
        
        IF    ${counter} == 3
              Click Button    ${SCROLLTOTHERIGHTBUTTON}
              Sleep    3
        END

        
        
        Wait Until Element Is Visible                                             ${LOCATORFINDEVENTS}
    
    END    

Então enviamos esses eventos para API
                
        Create Session        
        ...                                  alias=MyConenctionAPIHorizonEvents       
        ...                                  url=https://pjpw.vercel.app/    
        ...                                  disable_warnings=true
        

        FOR    ${counter}    IN RANGE    0    25    5  
            
            &{Body}                          Create Dictionary
            ...                              NomeEvento=${Eventos[${counter}]}
            ...                              DataEvento=${Eventos[${counter} + 1]}
            ...                              LocalEvento=${Eventos[${counter} + 2]}
            ...                              UrlEvento=${Eventos[${counter} + 3]}
            ...                              ImagemEvento=${Eventos[${counter} + 4]}
            
            &{Evento}                        Create Dictionary         #Esse novo dicionário foi criado com intuito de se adequar a estrutura JSON que se comunica com API, que sempre espera a chave responseData
            ...                              responseData=${Body}
            
           

            POST On Session
            ...                              alias=MyConenctionAPIHorizonEvents
            ...                              url=/criar
            ...                              json=${Evento}

        END
        

       
        
           
       
        
        

        
        
    
    
    


