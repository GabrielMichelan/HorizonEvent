*** Settings ***
Documentation                Suíte das Keywords relacionadas com a suíte "Eventos.robot" - Site da Byma. 

Resource                     ../Base.robot


*** Keywords ***
Dado que estamos na página inicial da Byma
    Go To                            url=${URLBYMA}   
    Wait Until Element Is Visible    locator=${HOMEPAGEBYMA}
    
Quando é feito a busca de eventos    
    Click Element                    locator=${SEARCHEVENTS}
    Wait Until Element Is Visible    locator=${EVENTSPAGE} 
                          
Então Acoplar eventos ilustrados na página      
    @{data_index_necessarios}               Create List

    FOR    ${counter}    IN RANGE    0    4

        Scroll Element Into View         ${LOADEVENTSBUTTON} 
        Click Button                     ${LOADEVENTSBUTTON}
        Sleep    5
        
    END
              
    @{lista_elements_data_index}             Get WebElements        css=div[data-index]

    FOR    ${element}    IN    @{lista_elements_data_index}

           ${ValorTagStyle}       SeleniumLibrary.Get Element Attribute    ${element}    style

           IF   '${ValorTagStyle}' == 'overflow-anchor: none;'
                 ${valordata_index}    SeleniumLibrary.Get Element Attribute    ${element}        data-index    
                 Append To List        ${data_index_necessarios}                ${valordata_index}                
           END 
                                
    END  

    #Removendo o elemento não clicável
    Remove From List    ${data_index_necessarios}    0 

        
    FOR    ${counter}    IN    @{data_index_necessarios}
        Click Element                    css=div[data-index="${counter}"] 
        Switch Window                    locator=NEW
        Wait Until Element Is Visible    ${LOCATORBYMA}                    timeout=15
        @{ElementsDataHoraLocal}         Get WebElements                  ${LOCATORDATEHOUREVENT}  
        ${TamanhoLista}                  Get Length                       ${ElementsDataHoraLocal}
        ${UrlEVento}                     Get Location
        ${ImageElement}                  Run Keyword And Return Status    Element Should Be Visible     ${LOCATORIMAGEELEMENT}     
        ${LinkLocalElement}              Run Keyword And Return Status    Element Should Be Visible     ${LOCATORLOCALLINK}
        IF    '${ImageElement}' == 'True'
               ${ImagemEvento}                  Get Element Attribute                                   ${LOCATORIMAGEELEMENT}                src                   
            
        ELSE
               ${ImagemEvento}                  Set Variable                                            Esse evento não possui imagem                   
            
        END   

        IF    '${LinkLocalElement}' == 'True'
               ${LinkLocalDoEvento}             Get Element Attribute                                   ${LOCATORLOCALLINK}                    href

        ELSE
               ${LinkLocalDoEvento}                  Set Variable                                       Esse evento não possui link da localização                  
            
        END   

        IF    ${TamanhoLista} == 0
              ${DataHoraEvento}                Set Variable                    Não foi possível coletar informações de data/hora                 
              ${LocalEvento}                   Set Variable                    Não foi possível coletar informação de local
              ${NomeEvento}                    Set Variable                    Não foi possível coletar informação do nome do evento
        ELSE
              ${DataHoraEvento}                Get Text                         locator=${ElementsDataHoraLocal[0]}
              ${LocalEvento}                   Get Text                         locator=${ElementsDataHoraLocal[1]}  
              ${NomeEvento}                    Get Text                         ${TITTLEVENT}
        END   
               
        &{Body}                          Create Dictionary
        ...                              NomeEvento=${NomeEvento}
        ...                              DataHora=${DataHoraEvento}
        ...                              UrlEvento=${UrlEVento}
        ...                              LocalEvento=${LocalEvento}
        ...                              LinkLocalEvento=${LinkLocalDoEvento}
        ...                              ImagemEvento=${ImagemEvento}
        
        &{Evento}                        Create Dictionary    #Esse novo dicionário foi criado com intuito de se adequar a estrutura JSON que se comunica com API, que sempre espera a chave responseData
        ...                              responseData=${Body}
       
        E Enviar para API                ${Evento}                                                               
        
        Close Window 

        Switch Window                    locator=MAIN

    END

E Enviar para API 
    [Arguments]            ${Body}
        Create Session        
        ...                    alias=MyConenctionAPIHorizonEvents       
        ...                    url=https://pjpw.vercel.app/    
        ...                    disable_warnings=true
        
        

        POST On Session
        ...                    alias=MyConenctionAPIHorizonEvents
        ...                    url=/criar
        ...                    json=${Body}
        

   
    
    


