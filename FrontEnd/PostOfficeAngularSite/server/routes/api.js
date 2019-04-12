const express = require('express');
const router = express.Router();

var mysql = require('mysql')

// Connect


const connection = mysql.createConnection({
  host: 'mysqlinstance.c0mjh6ewr0w9.us-east-2.rds.amazonaws.com',
  user: 'masterUsername',
  password: 'admin123',
  database: 'PostOffice'
});


connection.connect(function (err) {
    if (err) {
      console.error('error connecting: ' + err.stack);
      return;
    }

    console.log('connected as id ' + connection.threadId);
});

//LOGIN
//return ID of the User that logged in. email & password as params
router.get('/userLogin', (req, res) => {
  Email = req.query.email;
  Password = req.query.password
  connection.query('SELECT CustomerID FROM Customer WHERE Email = (SELECT CustomerEmail FROM CustomerLogin WHERE CustomerEmail = ? AND CustomerPassword = ?)', [Email, Password], function (err, rows, fields) {
    if (err) throw err
    res.json(rows);
    });
});

//TRACKING by ID return DATE Location City & state Package Send to address & status based on row
router.get('/packageTracking', (req, res) => {
  console.log(req.query.id);
  connection.query(
    'SELECT Tracking.Date, Location.City, Location.State, Package.SendToHouseNumber, Package.SendToStreet FROM Tracking LEFT JOIN Location ON Tracking.CurrentLocationID = Location.LocationID LEFT JOIN Package ON Package.PackageID = Tracking.PackageID WHERE Tracking.PackageID = ?',[req.query.id], function (err, rows, fields) {
      if (err) throw err
      for (var x in rows) {
        //last in tracking
        if (x == rows.length - 1) {
          if (rows[x].City == null) {
            rows[x].Status = "delivered";
            rows[x].City = rows[x].SendToHouseNumber;
            rows[x].State = rows[x].SendToStreet;
          }
          else {
            rows[x].Status = "in transit";
          }
        }
        //arived
        else if (x < rows.length - 1) {
          rows[x].Status = "arived";
        }
     
      }
    res.json(rows);
  });
});


//myPackages by user ID Return Package ID, SendTO address, ETA, status
router.get('/myPackages', (req, res) => {
  connection.query('SELECT Package.PackageID, Package.SendToHouseNumber, Package.SendToStreet, Package.SendToCity, Package.SendToState, Package.ETA, `Package State`.State FROM Package LEFT JOIN `Package State` ON `Package State`.PackageStateID = Package.PackageStateID WHERE CustomerID = ?', [req.query.id], function (err, rows, fields) {
    if (err) throw err
    res.json(rows);
  });
});


//packages going to Users ADDRESS by id RETURN Package ID, SendTO address, ETA, status
router.get('/packagesToAddress', (req, res) => {
  connection.query('SELECT Package.PackageID, Package.SendToHouseNumber, Package.SendToStreet, Package.SendToCity, Package.SendToState, Package.ETA, `Package State`.State FROM Package LEFT JOIN `Package State` ON `Package State`.PackageStateID = Package.PackageStateID LEFT JOIN Customer ON Package.SendToHouseNumber = Customer.HouseNumber AND Package.SendToStreet = Customer.Street AND Package.SendToZipCode = Customer.ZipCode  WHERE Customer.CustomerID = ?', [req.query.id], function (err, rows, fields) {
    if (err) throw err
    res.json(rows);
  });
});

router.get('/findLocation', (req, res) => {
  connection.query('SELECT Location.LocationID, Location.BuildingNumber, Location.ZipCode, Location.City, Location.State, Location.Hours FROM Location ORDER BY ABS(Location.ZipCode - ?) DESC', [req.query.zip], function (err, rows, fields) {
    if (err) throw err
    res.json(rows);
  });
});


module.exports = router;
