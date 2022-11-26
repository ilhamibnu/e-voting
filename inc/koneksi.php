<?php
$HOST = "localhost";
$USERNAME = "pemirahi_pemirahimajkg";
$PASSWORD = "selamatdatang#23";
$DATABASE = "pemirahi_evoting";
$koneksi = new mysqli($HOST, $USERNAME, $PASSWORD, $DATABASE);

// Check connection
if ($koneksi->connect_error) {
    die("Connection failed: " . $koneksi->connect_error);
}
