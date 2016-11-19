"TestApiDomainName" : {
    "Type" : "Custom::ApiDomainName",
        "Properties" : {
        "ServiceToken": "{Lambda_Function_ARN}",
            "domainName": "example.com",
            "certificateName": "testCertificate",
            "certificateBody": "-----BEGIN CERTIFICATE-----line1 line2 ... -----END CERTIFICATE-----",
            "certificateChain": "-----BEGIN CERTIFICATE-----line1 line2 ... -----END CERTIFICATE-----",
            "certificatePrivateKey": "-----BEGIN RSA PRIVATE KEY-----line1 line2 ... -----END RSA PRIVATE KEY-----"
    }
}

var params = {
    certificateBody: 'STRING_VALUE', /* required */
    certificateChain: 'STRING_VALUE', /* required */
    certificateName: 'STRING_VALUE', /* required */
    certificatePrivateKey: 'STRING_VALUE', /* required */
    domainName: 'STRING_VALUE' /* required */
};
apigateway.createDomainName(params, function(err, data) {
    if (err) console.log(err, err.stack); // an error occurred
    else     console.log(data);           // successful response
});