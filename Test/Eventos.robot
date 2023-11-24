*** Settings ***
Documentation                    Suíte responsável pelos testes nos sites de eventos

Resource                         ../Resources/Base.robot

Test Setup                        Open The Browser        
Test Teardown                     Close The Browser     

*** Test Cases ***
CT001: Coletar as informações dos eventos do site da Ingresse e realizar o envio para API 
    [Documentation]        CT001
    Dado que estamos na página inicial da Ingresse
    Quando pesquisarmos por um determinado evento        Laroc    
    Então os eventos devem ser ilustrados
    E deve ser armazenados os IDs de todos eventos pesquisados
    E enviado para API
    

CT002: Coletar as informações dos eventos do site da Byma e realizar o envio para API
    [Documentation]        CT002
    Dado que estamos na página inicial da Byma
    Quando é feito a busca de eventos
    Então Acoplar eventos ilustrados na página 

CT003: Coletar as informações dos eventos do site da Sympla e realizar o envio para API
    [Documentation]        CT003
    Dado que estamos na página inicial da Sympla
    Quando é feito a pesquisa de eventos 
    Então enviamos esses eventos para API


       