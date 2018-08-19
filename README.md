# ACME Airline Case Study. Version 9.

# Airline v9

https://hyperledger.github.io/composer/reference/acl_language.html

Refer to lecture on Access Control Language


#1 Create the BNA archive  
composer archive create  --sourceType dir --sourceName ../

#2.1 Install the archive  
composer network install -a ./airline@0.0.1.bna -c PeerAdmin@hlfv1

#2.2 Strart the network  
composer network start -n airline -c PeerAdmin@hlfv1 -V 0.0.1 -A admin -S adminpw

admin>> org.hyperledger.composer.system.NetworkAdmin#admin

#3 DO NOT - Import the card  
composer card delete -n admin@airline  
composer card import -f admin@airline.card

#4 Add a new participants

- John Doe (johnd) is the Network Administrator  
composer participant add -d '{"$class":"org.acme.airline.participant.ACMENetworkAdmin","participantKey":"johnd","contact":{"$class":"org.acme.airline.participant.Contact","fname":"John","lname":"Doe","email":"john.doe@acmeairline.com"}}' -c admin@airline

- Will Smith (wills) works in the Logistics department  
composer participant add -d '{"$class":"org.acme.airline.participant.ACMEPersonnel","participantKey":"wills","contact":{"$class":"org.acme.airline.participant.Contact","fname":"Will","lname":"Smith","email":"will.smith@acmeairline.com"}, "department":"Logistics"}' -c admin@airline

#5 Issue the identities  
composer identity issue -u johnd -a org.acme.airline.participant.ACMENetworkAdmin#johnd -c admin@airline

composer card delete -n johnd@airline  
composer card import -f johnd@airline.card

composer identity issue -u wills -a org.acme.airline.participant.ACMEPersonnel#wills -c admin@airline 

composer card delete -n wills@airline  
composer card import -f wills@airline.card

#6 Ping BNA using the johnd & wills cards  
    - composer network ping -c johnd@airline  
    - composer network ping -c wills@airline

#6 Setup the permissions.acl  
    - johnd     Is the Network Administrator for airlinev9  
                Should be able to execute network commands

    - wills     Works for the Logistics department  
                Should NOT be able to execute any network command

#7 Rebuild the archive  
composer archive create  --sourceType dir --sourceName ../

#8 Update the Network  
composer network update -a ./airline@0.0.1.bna -c admin@airline


composer-rest-server -c johnd@airline -n always -w true

Solutions  
=========  
// Returns all aircrafts  
query AllAircrafts {  
 description: "Returns all aircrafts in the registry"  
 statement:  
 SELECT org.acme.airline.aircraft.Aircraft  
}  
 
// Return aicrafts with specific ownership types  
query AircraftWithOwnershipTypes {  
 description: "Returns all aircrafts with specific ownership type"  
 statement:  
 SELECT org.acme.airline.aircraft.Aircraft  
 WHERE (ownershipType == _$ownership_type)  
}  
 
// Return aircrafts with specific number of seats  
query AircraftWithSeats {  
 description: "Returns aircrafts with specific number of seats"  
 statement:  
 SELECT org.acme.airline.aircraft.Aircraft  
 WHERE (firstClassSeats >= _$x AND businessClassSeats >= _$x AND economyClassSeats >= _$x)  
}  

