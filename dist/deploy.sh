# clear all .card and .bna
rm *.card
rm *.bna

# Create the archive
composer archive create  --sourceType dir --sourceName ../

# Install the archive
composer network install -a ./airlinev9@0.0.1.bna -c PeerAdmin@hlfv1

# Strart the network. (.card file will be created after this command)
composer network start -n airlinev9 -c PeerAdmin@hlfv1 -V 0.0.1 -A admin -S adminpw

# Delete old one and use the card newly generated.
composer card delete -c admin@airlinev9
composer card import -f admin@airlinev9.card

# add participants
composer participant add -d '{"$class":"org.acme.airline.participant.ACMENetworkAdmin","participantKey":"johnd","contact":{"$class":"org.acme.airline.participant.Contact","fName":"John","lname":"Doe","email":"john.doe@acmeairline.com"}}' -c admin@airlinev9
composer participant add -d '{"$class":"org.acme.airline.participant.ACMEPersonnel","participantKey":"wills","contact":{"$class":"org.acme.airline.participant.Contact","fName":"Will","lname":"Smith","email":"will.smith@acmeairline.com"}, "department":"Logistics"}' -c admin@airlinev9

# issue identities to the participants
composer identity issue -u johnd -a org.acme.airline.participant.ACMENetworkAdmin#johnd -c admin@airlinev9
composer identity issue -u wills -a org.acme.airline.participant.ACMEPersonnel#wills -c admin@airlinev9

# impoart their cards
composer card delete -c johnd@airlinev9
composer card import -f johnd@airlinev9.card

composer card delete -c wills@airlinev9
composer card import -f wills@airlinev9.card
