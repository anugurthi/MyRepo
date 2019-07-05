$xmlFilePath = "C:\\Users\\Saikiran_Anugurthi\\Desktop\\Powershell\\employee.xml"

if(![System.IO.File]::Exists($xmlFilePath)){
    New-Item $xmlFilePath
}
$doc = [xml](Get-Content -Path $xmlFilePath)


$addMainTag = AddMainTag

$userInput = Read-Host -Prompt 'Enter Employee for Employee or Employer for Employer'

if($userInput -eq 'Employee')
{
    $childNodeInput = Read-Host -Prompt 'Type Add to Adding , Del to delete , Modify to Update'
    AddEmployeeChild

}
elseif($userInput -eq 'Employer') 
{
    AddEmployerChild
}
else{
    Write-Warning 'Invalid Input'
}

function checkTheUserInputAndPerformForEmployeeNode($childNodeInput){
if($childNodeInput -eq 'Add'){
AddEmployeeChild
Write-Host $childNodeInput
}
elseif($childNodeInput -eq 'Del'){
Write-Host $childNodeInput
}
elseif($childNodeInput -eq 'Modify'){
Write-Host $childNodeInput
}
elseif($childNodeInput -eq 'GetEmp'){
Write-Host $childNodeInput
}
else{
Write-Warning 'Invalid Input'
}
}

function CheckEmployerBeforeAddingEmployee($Employer){
$XMLDocument=New-Object System.XML.XMLDocument  
$XMLDocument.Load($xmlFilePath)
$employers = $XMLDocument.config.Employers

foreach ($empr in $employers)
{
if($empr -ne $Employer){
 throw 'Please Register Employer fisrt'
}
}
}
function CheckEmployerExists($Employer){
$XMLDocument=New-Object System.XML.XMLDocument  
$XMLDocument.Load($xmlFilePath)
$employers = $XMLDocument.config.Employers.employer

foreach ($empr in $employers)
{
Write-Host $empr.Name
if($empr.Name -eq $Employer){
 throw 'Employer already Exists..'
}
}
}

function AddEmployeeChild()
{
$Name = Read-Host -Prompt 'Enter Name '
$Employer = Read-Host -Prompt 'Enter Employer '
$Age = Read-Host -Prompt 'Enter Age '
$Designation = Read-Host -Prompt 'Enter Designation '

CheckEmployerBeforeAddingEmployee -Employer $Employer

$fileName = $xmlFilePath;
$xmlDoc = [System.Xml.XmlDocument](Get-Content $fileName);

$newXmlEmployee = $xmlDoc.config.Employees.AppendChild($xmlDoc.CreateElement("employee"));

CreateNode -key "Name" -value $Name
CreateNode -key "Employer" -value $Employer
CreateNode -key "Age" -value $Age
CreateNode -key "Designation" -value $Designation

$xmlDoc.Save($fileName);
}

function ModifyEmployeeChild($name,$employer,$age,$address)
{
$Name = Read-Host -Prompt 'Enter Name '
$Employer = Read-Host -Prompt 'Enter Employer '
$Age = Read-Host -Prompt 'Enter Age '
$Designation = Read-Host -Prompt 'Enter Designation '

$fileName = $xmlFilePath;
$xmlDoc = [System.Xml.XmlDocument](Get-Content $fileName);

$newXmlEmployee = $xmlDoc.config.Employees.AppendChild($xmlDoc.CreateElement("employee"));

CreateNode -key "Name" -value $Name
CreateNode -key "Employer" -value $Employer
CreateNode -key "Age" -value $Age
CreateNode -key "Designation" -value $Designation

$xmlDoc.Save($fileName);
}

function DelEmployeeChild()
{
$Name = Read-Host -Prompt 'Enter Name '
$Employer = Read-Host -Prompt 'Enter Employer '
$Age = Read-Host -Prompt 'Enter Age '
$Designation = Read-Host -Prompt 'Enter Designation '

$fileName = $xmlFilePath;
$xmlDoc = [System.Xml.XmlDocument](Get-Content $fileName);

$newXmlEmployee = $xmlDoc.config.Employees.AppendChild($xmlDoc.CreateElement("employee"));

CreateNode -key "Name" -value $Name
CreateNode -key "Employer" -value $Employer
CreateNode -key "Age" -value $Age
CreateNode -key "Designation" -value $Designation

$xmlDoc.Save($fileName);
}

function AddEmployerChild($name,$employer,$age,$address)
{
$Name = Read-Host -Prompt 'Enter Name '
$Address = Read-Host -Prompt 'Enter Address '
$GST_ID = Read-Host -Prompt 'Enter GST_ID '

CheckEmployerExists -Employer $Name

$fileName = $xmlFilePath;

$xmlDoc = [System.Xml.XmlDocument](Get-Content $fileName);

$newXmlEmployee = $xmlDoc.config.Employers.AppendChild($xmlDoc.CreateElement("employer"));

CreateNode -key "Name" -value $Name
CreateNode -key "Address" -value $Address
CreateNode -key "GST_ID" -value $GST_ID

$xmlDoc.Save($fileName);
}
function AddMainTag(){

if(!$doc){

# Create a new XML File with config root node
[System.XML.XMLDocument]$oXMLDocument=New-Object System.XML.XMLDocument

# New Node
[System.XML.XMLElement]$oXMLRoot=$oXMLDocument.CreateElement("config")

# Append as child to an existing node
$oXMLDocument.appendChild($oXMLRoot)

# Add a Attribute
$oXMLRoot.SetAttribute("description","Config file for testing")

[System.XML.XMLElement]$oXMLSystem=$oXMLRoot.appendChild($oXMLDocument.CreateElement("Employees"))
$oXMLSystem.SetAttribute("description","Employee information")


[System.XML.XMLElement]$oXMLSyste=$oXMLRoot.appendChild($oXMLDocument.CreateElement("Employers"))
$oXMLSyste.SetAttribute("description","Employer information")

# Save File
$oXMLDocument.Save($xmlFilePath)
}
}

function CreateNode($key,$value){
$newXmlNameElement = $newXmlEmployee.AppendChild($xmlDoc.CreateElement($key));
$newXmlNameTextNode = $newXmlNameElement.AppendChild($xmlDoc.CreateTextNode($value));
}
