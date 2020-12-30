# Logstash-Certificates
Simplify creation of Logstash SSL certificates.

## Download Elasticsearch and Logstash
1. Clone the repo
2. Make sure that you have Ubuntu (min version 18) setup with all basic dependencies including java.
3. Run sh 0_download_es_logstash.sh - this will download logstash and elasticsearch and configure services for them. (debian style installation)

```
sh ./0_download_es_logstash.sh
```

It installs different parts of the packages in different places.
For eg.
a. the config files are located in /etc/(logstash/elasticsearch)
b. the bin files are located in usr/share/(elasticsearch/logstash)
c. you can use this type of installation, preferably as it starts up logstashby default.

4. If you want to download logstash and elasticsearch as individual files, you can download them and put them in the folder of your choice, but then you have manually configure the env vars.

## Setup ENV VARS automatically

Do this if you installed elasticsearch and logstash using the sh script above

Run 

```
sh ./1_set_env_vars.sh
```

This will automatically set the environment variables:
(they get added to root's ~/.bashrc and /etc/environment)
1. SSL_CERTIFICATES_PATH
2. ELASTICSEARCH PATH
3. IP_ADDRESSES
4. LOGSTASH PORT

You can change them directly in the above two files if you need to.

## Setup ENV VARS Manually

Do this if you installed logstash and elasticsearch as zip/tar packages into directories of your choice.

```
export ELASTICSEARCH_PATH="/path/to/elasticsearch/directory"
export SSL_CERTIFICATES_PATH="/path/to/logstash/directory"

## the ip addresses where logstash will be running, make sure they are comma seperated. This is useful if you have logstash running on more than one IP, or your network has more than one IP address.
## by default logstash runs on 0.0.0.0 and so in the logstash_ssl.conf, I haven't explicitly mentioned a host.
## I have made sure to add 0.0.0.0 in the IP addresses here, so that the certificate will allow clients, hitting 0.0.0.0.
## your clients can also use your machines IP address, like 192.168.1.5 for eg (you can find this in wifi-settings in your ethernet connection)
## basically add as many ip's as you like, to make sure the certificate includes them. Then as long as logstash is running on these IP's everything works.

export IP_ADDRESSES="0.0.0.0,192.168.1.5,192.168.1.13"

## IN order to test your certificates, using sh ./check_cert, curl needs to know which IP address to hit. By default check_cert will use 0.0.0.0 as the IP address to test the certificate against logstash. If however, you already know which IP address your Logstash is running on, simply export and env var like this, and the script uses that instead. This is also used by the sample ruby script, which will otherwise try to resolve the machine's ip address and use that.
export IP_ADDRESS="0.0.0.0" 


## the hostname of your machine(the qualified host like: www.google.com, where logstash will run, if it is running on a domain.)
export HOSTNAME="www.example.com"

## the port at which logstash will be running
export LOGSTASH_PORT=1443
```


## Generate Certificates:

```
./sh make_cert.sh
```

The commmand should create a directory called "ssl_certificates" under your SSL_CERTIFICATES_PATH directory. It will contain two directories "host" and "ca". The host contains the client key and certificate. the "ca" directory contains the CA key and certificate.

5. Copy the logstash_ssl.conf file from the repo to the logstash config directory(either /etc/logstash/conf.d/ or your own custom place where you installed logstash). This file contains logstash configuration for a 'tcp' input.

```
cp ./logstash_ssl.conf path/to/logstash-/config/
```

6. Run the logstash server with the configuration file

```
#to start logstash as a service
# sudo systemctl stop logstash.service
# sudo systemctl start logstash.service

# from logstash root directory
bin/logstash -f ./config/logstash_ssl.conf
```

THe server should boot without errors. If you got any errors, you did something wrong.

7. Check if ssl works, by running 

```
sh ./check_cert.sh
```

The last couple of line sof the output should be something like :

```
* Server certificate:
*  subject: CN=host
*  start date: Dec 25 08:03:03 2020 GMT
*  expire date: Dec 25 08:03:03 2023 GMT
*  subjectAltName: host "192.168.1.13" matched cert's IP address!
*  issuer: CN=Elastic Certificate Tool Autogenerated CA
*  SSL certificate verify ok.
> GET / HTTP/1.1
> Host: 192.168.1.13:1443
> User-Agent: curl/7.58.0
> Accept: */*
```
The important line is "SSL certificate verify ok." and the last line with "Accept: */*"

If you reached this point, any SSL client with the client key, client certificate and the CA certificate can now ship logs to logstash at port 1443. You can change this port in the logstash_ssl.conf file if you want to.
Note that you need to open this port to the outside world, on your machine, if you want to receive logs from the outside.

### Points to note:
We didn't explicitly specify a hostname in the logstash_ssl.conf file's tcp => input.
This is because it defaults to 0.0.0.0 and that is already included in our certificates.
If your logstash port is open to the external internet, you can leave this as it is, since traffic on your machines IP address will automatically get forwarded to 0.0.0.0. If logstash is not open to the public internet and you want it running on a specific host, you can specify that, but make sure to add it to your ENV['IP_ADDRESSES'].

## Send Rails Logs to Logstash over SSL:

Check the ruby_ssl.rb file to see how to use a simple tcp socket to send logs to logstash using the certificates we created above.

## Configure mailgun with postfix

Follow entire setup at following link
https://www.digitalocean.com/community/tutorials/how-to-set-up-a-mail-relay-with-postfix-and-mailgun-on-ubuntu-16-04
If your domain is already configured with mailgun through your domain host(for DNS), you don't need to do the entire DNS/CNAME Part of it.
Go directly to the postfix configuration. You only need the username, password from your mailgun domain settings.
