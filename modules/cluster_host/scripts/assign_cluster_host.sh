
#!/bin/bash
ibmcloud login --apikey=$API_KEY -a $ENDPOINT -r $REGION -g $RESOURCE_GROUP
ibmcloud iam oauth-tokens

if [ "$PROVIDER" == "aws" ]; then
    hostname=$(echo $hostname | cut -d "." -f 1)
fi

host_out=`ibmcloud sat host ls --location $location | grep $hostname`
HOST_ID=$(echo $host_out| cut -d' ' -f 2)


echo hostout= $host_out
echo hostid= $HOST_ID
echo hostname= $hostname
echo location= $location
echo cluster= $cluster_name
echo provider= $PROVIDER

ibmcloud sat host assign --cluster $cluster_name --location $location --host $HOST_ID --zone $zone

status='Not Ready'
echo $status
while [ "$status" != "Ready" ]
do
   if [[ $(ibmcloud sat host ls --location $location | grep $hostname) == *"Ready"* ]]; then
    echo host $hostname Ready
    status="Ready"
  fi
    echo "************* hosts Not ready *****************"
    sleep 10
done

echo "************* Completed.. *************"
exit 0