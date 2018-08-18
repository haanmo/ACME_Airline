# Create the archive
composer archive create  --sourceType dir --sourceName ../

# Install the archive
composer network install -a ./airline@0.0.1.bna -c PeerAdmin@hlfv1

# Strart the network. (.card file will be created after this command)
composer network start -n airline -c PeerAdmin@hlfv1 -V 0.0.1 -A admin -S adminpw

# Use the card generated
composer card import -f admin@airline.card
