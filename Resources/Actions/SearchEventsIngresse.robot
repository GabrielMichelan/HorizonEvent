*** Settings ***
Documentation                Suíte das Keywords relacionadas com a suíte "Eventos.robot" - Site da ingresse. 


Resource                     ../Base.robot



*** Keywords ***

Dado que estamos na página inicial da Ingresse
    Go To                            url=${URLINGRESSE} 
    Wait Until Element Is Visible    locator=${CONFIRMBUTTON}
    Click Button                     locator=${CONFIRMBUTTON}
    
    
Quando pesquisarmos por um determinado evento 
    [Arguments]                      ${EventSearched}
    Wait Until Element Is Visible    locator=${SEARCHLABEL}
    Input Text                       locator=${SEARCHLABEL}      text=${EventSearched}
    Press Keys                       None                        \ue007
    Set Test Variable                ${EventSearched}       
    
Então os eventos devem ser ilustrados
    Wait Until Page Contains               text=Eventos com o termo "${EventSearched}" em todo Brasil    timeout=20 
    Sleep                                  20
    
E deve ser armazenados os IDs de todos eventos pesquisados
    @{EventosIDs}          Get WebElements    ${EVENTSCARDS}

    @{ListaIDS}            Create List    
 
    FOR    ${element}    IN    @{EventosIDs}
        ${Tag_ID}         SeleniumLibrary.Get Element Attribute   ${element}   id
        ${ID_Number}      Get Substring        ${Tag_ID}          16           21 
        Append To List    ${ListaIDS}          ${ID_Number}                      
    END
    
    Set Test Variable   ${ListaIDS}
      
E enviado para API
    
    ${TamanhoDaLista}        Get Length        ${ListaIDS}

    FOR    ${counter}    IN RANGE    0        ${TamanhoDaLista}    
        
        Create Session    
        ...                       alias=MyConenctionAPIIngresse        
        ...                       url=https://api.ingresse.com        
        ...                       disable_warnings=true
    
        ${UriSession}             Set Variable            /event/${ListaIDS[${counter}]}

        &{QueryParametro}         Create Dictionary
        ...                       apikey=${APIKEY}

        ${ResponseGetRequest}     GET On Session
        ...                       alias=MyConenctionAPIIngresse
        ...                       url=/event/${ListaIDS[${counter}]}
        ...                       params=${QueryParametro}
        
        Create Session        
        ...                       alias=MyConenctionAPIHorizonEvents       
        ...                       url=https://pjpw.vercel.app/   
        ...                       disable_warnings=true
        
        ${ResponsePostRequest}    POST On Session         
        ...                       alias=MyConenctionAPIHorizonEvents        
        ...                       url=/criar          
        ...                       json=${ResponseGetRequest.json()}
        
       Should Be True    ${ResponsePostRequest.status_code} == 201 or ${ResponsePostRequest.status_code} == 200
       ...               msg=Status Code diferente de 200/201, o status é: ${ResponsePostRequest}
    
    END


    