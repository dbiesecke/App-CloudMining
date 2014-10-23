App-CloudMining
===================

perl app to show stats from cloud mining provider like zencloud. 
The main sense it, to run it on a secure server as cronjob to push the Stats als Webhook
to other Services like [Zapier](http://zapier.com)

For the moment only zencloud is available.

For Easy usage: a Docker autobuild exist, use it with: `docker pull dbiesecke/app-cloudmining`

      
      usage:
          cloudmining zencloud <username> <password> [long options...]
          cloudmining help
          cloudmining zencloud --help
      
      description:
           zecloud api commands 
      
      parameters:
          username  Username for login [Required; Important!]
          password  Password for login [Required; Important!]
      
      options:
          --as_csv               Print as csv [Flag]
          --as_json              Print as JSON [Flag]
          --config              Path to command config file
          --debug               set Debug mode for verbose  [Flag]
          --help -h --usage -?  Prints this usage information. [Flag]
          --show_miner -s        Verbose miner stat's output  [Flag]
          --verbose             set verbose to show more stats [Flag]
          --webhook -w          Webhook URL to push your stats  [Default:""]




v0.0001 - First Release
-----------------------------

* Can push the result as webhook to services like [Zapier](http://zapier.com)

* Small stats can also printed as CSV:  `$0 zencloud --as_csv --as_json=false -s <USER> PASSWORD>`


        Coin,est_payout,power,activated
        BTC     0.01281803      951.998 10/17/2014
        Scrypt  0.08127414      90.188  10/14/2014




* Show small stats ( without -s switch ), Default for the moment `$0 zencloud  <USER> PASSWORD>`


        {  
           "totalScryptHashpower":"91.754 MH",
           "btc_deposit":" 0.00750092",
           "btcUSD":"2.74 USD",
           "totalBtcHashpower":"878.070 GH",
           "btc24hPayout":"0.1084 BTC",
           "btc_addr":"1mNCBUzAgh697ME1EMXXXXXXXXXXXXXXXX"
        }



* Show small stats ( with -s switch ).  `$0 zencloud -s <USER> PASSWORD>`




        {  
           "btc24hPayout":"0.0110 BTC",
           "btc_addr":"1JHtq38EzysKHZGVrr7aXXXXXXXX",
           "totalScryptHashpower":"30.128 MH",
           "btc_deposit":" 0.02682629",
           "btcUSD":"9.81 USD",
           "feeUSD":2.4,
           "miner":[  
              {  
                 "feeUSD":"2.24000000",
                 "power":"28.409",
                 "name":"Hashlet 1",
                 "coin":"Scrypt",
                 "sellprice":"0",
                 "activated":"10/17/2014",
                 "est_payoutBTC":"0.00887795"
              },
              {  
                 "sellprice":"0",
                 "activated":"10/18/2014",
                 "est_payoutBTC":"0.00099870",
                 "power":"1.029",
                 "name":"Hashlet Prime 1",
                 "coin":"Scrypt",
                 "feeUSD":"0.08000000"
              },
              {  
                 "sellprice":"31.6",
                 "activated":"10/01/2014",
                 "est_payoutBTC":"0.00057479",
                 "feeUSD":"0.08000000",
                 "power":"42.800",
                 "name":"Hashlet Genesis 10",
                 "coin":"BTC"
              }
           ],
           "totalBtcHashpower":"40.520 GH",
           "btc24hPayout_est":0.01045144
        }
