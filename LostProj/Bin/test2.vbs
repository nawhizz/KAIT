Option Explicit

Dim userkey
Dim data

userkey = "K2I5I4S3L3C0H1U1"
data = "À¯¿µ¹è"
Test userkey, data


Function Test(userkey, data)
	Dim oSeed
	Dim encdata, decdata

	WScript.Echo "Key        : " & userkey
	WScript.Echo "Plaintext  : " & data

	Set oSeed = CreateObject("ECPlaza.Seed")
	encdata = oSeed.Encrypt(data, userkey)

	WScript.Echo vbCrLf & "Encryption...."
	WScript.Echo "Ciphertext : " & encdata
	
	WScript.Echo vbCrLf & "Decryption...."
	decdata = oSeed.Decrypt(encdata, userkey)
	WScript.Echo "Plaintext  : " & decdata

	
	WScript.Echo
	WScript.Echo
End Function


