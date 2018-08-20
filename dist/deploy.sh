
# clear all .card and .bna
rm *.card
rm *.bna

# Create the archive
composer archive create  --sourceType dir --sourceName ../

# Install the archive
composer network install -a ./airline@0.0.1.bna -c PeerAdmin@hlfv1

# Strart the network. (.card file will be created after this command)
composer network start -n airline -c PeerAdmin@hlfv1 -V 0.0.1 -A admin -S adminpw

# Delete old one and use the card newly generated.
composer card delete -c admin@airline
composer card import -f admin@airline.card

# add participants
composer participant add -d '{"$class":"org.acme.airline.participant.ACMENetworkAdmin","participantKey":"johnd","contact":{"$class":"org.acme.airline.participant.Contact","fname":"John","lname":"Doe","email":"john.doe@acmeairline.com"}}' -c admin@airline
composer participant add -d '{"$class":"org.acme.airline.participant.ACMEPersonnel","participantKey":"wills","contact":{"$class":"org.acme.airline.participant.Contact","fname":"Will","lname":"Smith","email":"will.smith@acmeairline.com"}, "department":"Logistics"}' -c admin@airline

# issue identities to the participants
composer identity issue -u johnd -a org.acme.airline.participant.ACMENetworkAdmin#johnd -c admin@airline
composer identity issue -u wills -a org.acme.airline.participant.ACMEPersonnel#wills -c admin@airline

# impoart their cards
composer card delete -c johnd@airline
composer card import -f johnd@airline.card

composer card delete -c wills@airline
composer card import -f wills@airline.card

