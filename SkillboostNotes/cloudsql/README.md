This is the commands given from the task about CLOUD SQL

### Export location
```bash
export LOCATION=US

export LOCATION=EU

export LOCATION=ASIA
```
This will depend on which region is chosen

### Bucket making
```bash
gcloud storage buckets create -l $LOCATION gs://$DEVSHELL_PROJECT_ID
```
`$DEVSHELL_PROJECT_ID` is an environment variable refering to the project ID, if done in Cloud Shell

### Image recieving
```bash
gcloud storage cp my-excellent-blog.png gs://$DEVSHELL_PROJECT_ID/my-excellent-blog.png
```

### Modify access control list
```bash
gsutil acl ch -u allUsers:R gs://$DEVSHELL_PROJECT_ID/my-excellent-blog.png
```
This makes it readable by everyone

## Applicable
After making a Cloud SQL
```bash
cd /var/www/html

sudo nano index.php
```

```php
<html>
<head><title>Welcome to my excellent blog</title></head>
<body>
<h1>Welcome to my excellent blog</h1>
<?php
 $dbserver = "CLOUDSQLIP";
$dbuser = "blogdbuser";
$dbpassword = "DBPASSWORD";
// In a production blog, we would not store the MySQL
// password in the document root. Instead, we would store
//  it in a Secret Manger. For more information see 
// https://cloud.google.com/sql/docs/postgres/use-secret-manager

 try {
  $conn = new PDO("mysql:host=$dbserver;dbname=mysql", $dbuser, $dbpassword);
  // set the PDO error mode to exception
  $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
  echo "Connected successfully";
} catch(PDOException $e) {
  echo "Database connection failed:: " . $e->getMessage();
}

?>
</body></html>
```

```bash
sudo service apache2 restart
```

The `CLOUDSQLIP` should be changeed to the Public IP address of the Cloud SQL.

The `DBPASSWORD` should be changed to password of the provided user `blogdbuser`

### Demonstrating the Storage
Add the following to before `<h1>` but after the first `<body>`
```html
<img src='https://storage.googleapis.com/qwiklabs-gcp-0005e186fa559a09/my-excellent-blog.png'>
```
The `qwiklabs-gcp-0005e186fa559a09` should be changed to the current project ID 