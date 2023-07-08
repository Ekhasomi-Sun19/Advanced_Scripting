Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
$form = New-Object System.Windows.Forms.Form

$form.Text = 'Student Questionnaire'
$form.Size = New-Object System.Drawing.Size(400,200)
$form.StartPosition = 'CenterScreen'
$okButton = New-Object System.Windows.Forms.Button
$okButton.Location = New-Object System.Drawing.Point(120,100)
$okButton.Size = New-Object System.Drawing.Size(75,23)
$okButton.Text = 'OK'
$okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $okButton
$form.Controls.Add($okButton)

$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Location = New-Object System.Drawing.Point(200,100)
$cancelButton.Size = New-Object System.Drawing.Size(75,23)
$cancelButton.Text = 'Cancel'
$cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $cancelButton
$form.Controls.Add($cancelButton)

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(60,25)
$label.Size = New-Object System.Drawing.Size(280,20)
$label.Text = 'What is the best coding language?'
$form.Controls.Add($label)
$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point(60,45)
$textBox.Size = New-Object System.Drawing.Size(260,100)
$form.Controls.Add($textBox)
$form.Topmost = $true


$form.Add_Shown({$textBox.Select()})
$result = $form.ShowDialog()
if ($result -eq [System.Windows.Forms.DialogResult]::OK)

{
$x = $textBox.Text
$x
}
