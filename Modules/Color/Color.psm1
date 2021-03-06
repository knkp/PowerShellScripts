class Style {
	hidden [Int32]$__Black = 0
	hidden [Int32]$__Red = 1
	hidden [Int32]$__Green = 2
	hidden [Int32]$__Brown = 3
	hidden [Int32]$__Blue = 4
	hidden [Int32]$__Purple = 5
	hidden [Int32]$__Cyan = 6
	hidden [Int32]$__White = 7
	hidden [Int32[]]$__styleCodes = @()
	static [Style]Color() {
		return [Style]::new()
	}
	[Style]Black() {
		$this.__styleCodes += (30 + $this.__Black)
		return $this
	}
	[Style]Red() {
		$this.__styleCodes += (30 + $this.__Red)
		return $this
	}
	[Style]Green() {
		$this.__styleCodes += (30 + $this.__Green)
		return $this
	}
	[Style]Brown() {
		$this.__styleCodes += (30 + $this.__Brown)
		return $this
	}
	[Style]Blue() {
		$this.__styleCodes += (30 + $this.__Blue)
		return $this
	}
	[Style]Purple() {
		$this.__styleCodes += (30 + $this.__Purple)
		return $this
	}
	[Style]Cyan() {
		$this.__styleCodes += (30 + $this.__Cyan)
		return $this
	}
	[Style]White() {
		$this.__styleCodes += (30 + $this.__White)
		return $this
	}
	[Style]BlackB() {
		$this.__styleCodes += (40 + $this.__Black)
		return $this
	}
	[Style]RedB() {
		$this.__styleCodes += (40 + $this.__Red)
		return $this
	}
	[Style]GreenB() {
		$this.__styleCodes += (40 + $this.__Green)
		return $this
	}
	[Style]BrownB() {
		$this.__styleCodes += (40 + $this.__Brown)
		return $this
	}
	[Style]BlueB() {
		$this.__styleCodes += (40 + $this.__Blue)
		return $this
	}
	[Style]PurpleB() {
		$this.__styleCodes += (40 + $this.__Purple)
		return $this
	}
	[Style]CyanB() {
		$this.__styleCodes += (40 + $this.__Cyan)
		return $this
	}
	[Style]WhiteB() {
		$this.__styleCodes += (40 + $this.__White)
		return $this
	}
	[Style]Bold() {
		$this.__styleCodes += 1
		return $this
	}
	[Style]Underline() {
		$this.__styleCodes += 4
		return $this
	}
	[String]Write([String]$val) {
		$result = "$([char]27)["
		foreach ($code in $this.__styleCodes) {
			$result += $code.ToString() + ';'
		}
		$result += 'm'
		$result += $val
		$result += "$([char]27)[m"
		return $result
	}
	[String]WriteColor([UInt32]$fore, [UInt32]$back, [string]$val) {
		$result = "$([char]27)["
		$result += "48;2;"
		$result += ($back -shr 16 -band 255).ToString() + ";"
		$result += ($back -shr 8 -band 255).ToString() + ";"
		$result += ($back -band 255).ToString() + ";"
		$result += "38;2;"
		$result += ($fore -shr 16 -band 255).ToString() + ";"
		$result += ($fore -shr 8 -band 255).ToString() + ";"
		$result += ($fore -band 255).ToString() + ""
		$result += "m"
		$result += $val
		$result += "$([char]27)[m"
		return $result
	}
	[String]WriteGradient([UInt32]$foreStart, [UInt32]$foreEnd, [UInt32]$backStart, [UInt32]$backEnd, [string]$val) {
		$foreRStart = ($foreStart -shr 16 -band 255)
		$foreREnd = ($foreEnd -shr 16 -band 255)
		$foreRDiff = ($foreREnd - $foreRStart) / $val.Length
		$foreGStart = ($foreStart -shr 8 -band 255)
		$foreGEnd = ($foreEnd -shr 8 -band 255)
		$foreGDiff = ($foreGEnd - $foreGStart) / $val.Length
		$foreBStart = ($foreStart -band 255)
		$foreBEnd = ($foreEnd -band 255)
		$foreBDiff = ($foreBEnd - $foreBStart) / $val.Length
		$backRStart = ($backStart -shr 16 -band 255)
		$backREnd = ($backEnd -shr 16 -band 255)
		$backRDiff = ($backREnd - $backRStart) / $val.Length
		$backGStart = ($backStart -shr 8 -band 255)
		$backGEnd = ($backEnd -shr 8 -band 255)
		$backGDiff = ($backGEnd - $backGStart) / $val.Length
		$backBStart = ($backStart -band 255)
		$backBEnd = ($backEnd -band 255)
		$backBDiff = ($backBEnd - $backBStart) / $val.Length
		$result = ""
		for ($i = 0; $i -lt $val.Length; $i++) {
			$newForeColor = (($foreRStart + ($foreRDiff * $i)) -shl 16) + (($foreGStart + ($foreGDiff * $i)) -shl 8) + (($foreBStart + ($foreBDiff * $i)))
			$newBackColor = (($backRStart + ($backRDiff * $i)) -shl 16) + (($backGStart + ($backGDiff * $i)) -shl 8) + (($backBStart + ($backBDiff * $i)))
			$result += $this.WriteColor($newForeColor, $newBackColor, $val.Substring($i, 1))
		}
		return $result
	}
}


function Color() {
	return [Style]::new()
}

Export-ModuleMember -Function Color
