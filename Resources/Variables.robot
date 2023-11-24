*** Variables ***
${URLBYMA}                    https://byma.com.br/   
${HOMEPAGEBYMA}               xpath=//div[contains(@class,'flex flex-col space-y-6 items-center justify-center h-4 lg:h-6 w-24 ')]
${SEARCHEVENTS}               xpath=//a[@class='text-gray-900 hover:text-primary active:text-red-700 text-md font-bold transition duration-100'][contains(.,'Explorar eventos')]
${EVENTSPAGE}                 xpath=//p[contains(.,'Carregar mais eventos')]
${ButtonMenu}                 xpath=//button[@class='flex space-x-2 items-center'][contains(.,'Menu')]
${ElementEntrar}              xpath=//button[@class='btn btn-primary w-full'][contains(.,'Entrar')] 
${LOADEVENTSBUTTON}           css=button[class="btn"]
${LOCATORDATEHOUREVENT}       css=p[class="tracking-tight text-sm"]
${LOCATORIMAGEELEMENT}        css=img[src^="https://res.cloudinary.com/htkavmx5a/image"] 
${LOCATORLOCALLINK}           css=a[href^="https://www.google.com/maps"]
${LOCATORBYMA}                css=a[alt="Byma"]
${TITTLEVENT}                 css=h1[class="text-2xl font-bold tracking-tighter"]
${URLINGRESSE}                https://www.ingresse.com/
${CONFIRMBUTTON}              id=state_btn_confirm
${SEARCHLABEL}                id=search_  
${SEARCHBUTTON}               xpath=//i[contains(@class,'aph icon-search cursor-pointer')] 
${EVENTSCARDS}                css=a[id^="event-card-link-"]
${URLSYMPLA}                  https://www.sympla.com.br/
${SYMPLASLOGAN}               css=a[aria-label="Sympla sua plataforma de eventos. Logo."]
${ACCEPTCOOKIESBUTTON}        css=button[id="onetrust-accept-btn-handler"]
${EVENTSCATEGORY}             xpath=//img[@src='https://images.sympla.com.br/651596056d6be.png']
${DIFFERENTBUYPAGE}           xpath=//div[@class='action center style-scope app-button'][contains(.,'COMPRAR INGRESSOS')]
${SCROLLTOTHERIGHTBUTTON}     xpath=(//button[contains(@width,'30')])[2]
${LOCATOREVENTDATE}           css=div[class="sc-1sp59be-1 fZlvlB"]
${LOCATOREVENTCARD}           css=a[class="EventCardstyle__CardLink-sc-1rkzctc-3 eDXoFM sympla-card"]
${LOCATOREVENTNAME}           css=h3[class="EventCardstyle__EventTitle-sc-1rkzctc-7 hwgihT animated fadeIn"]
${LOCATOREVENTLOCAL}          css=div[class="EventCardstyle__EventLocation-sc-1rkzctc-8 heVhPT animated fadeIn"] 
${LOCATOREVENTIMAGE}          css=img[src^="https://images.sympla"]
${LOCATORINITIALPAGE}         xpath=//h2[@class='SectionContainerstyle__SectionContainerTitle-sc-16q2ofz-4 jjwtcN'][contains(.,'Se joga, viver é agora!')]                                                                                           
${LOCATORFINDEVENTS}          xpath=//span[contains(.,'Encontre eventos')]
