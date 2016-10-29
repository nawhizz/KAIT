Option Explicit

Dim userkey
Dim data

userkey = "1234567890123456"
data = "This is a test."
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


