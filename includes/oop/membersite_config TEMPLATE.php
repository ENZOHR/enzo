<?PHP
require_once("membersite.php");

$fgmembersite = new FGMembersite();

$fgmembersite->InitDB('localhost','[ user ]','[ password ]','[ db name ]');

$fgmembersite->SetRandomKey(' [ key hash ]');

?>